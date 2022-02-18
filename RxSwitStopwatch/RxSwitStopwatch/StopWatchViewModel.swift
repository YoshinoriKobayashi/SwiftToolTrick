//
//  StopWatchViewModel.swift
//  RxSwitStopwatch
//
//  Created by kobayashi on 2022/02/17.
//

import Foundation
import RxSwift
import RxCocoa

protocol StopWatchViewModelInputs: AnyObject {
    var isPauseTimer: PublishRelay<Bool> { get }
    var isResetButtonTaped: PublishRelay<Void> { get }
}

protocol StopWatchViewModelOutputs: AnyObject {
    var isTimerWorked: Driver<Bool> { get }
    var timerText: Driver<String> { get }
    var isResetButtonHidden: Driver<Bool> { get }
}

protocol StopWatchViewModelType: AnyObject {
    var inputs: StopWatchViewModelInputs { get }
    var outputs: StopWatchViewModelOutputs { get }
}

final class StopWatchViewModel: StopWatchViewModelType, StopWatchViewModelInputs, StopWatchViewModelOutputs {
    
    var inputs: StopWatchViewModelInputs { return self }
    var outputs: StopWatchViewModelOutputs{ return self }
    
    // MARK: - Input
    let isPauseTimer = PublishRelay<Bool>()
    var isResetButtonTaped = PublishRelay<Void>()
    
    // MARK: - Output
    let isTimerWorked: Driver<Bool>
    let timerText: Driver<String>
    let isResetButtonHidden: Driver<Bool>
    
    private let disposeBag = DisposeBag()
    private let totalTimerDuration = BehaviorRelay<Int>(value: 0)
    
    init() {
        isTimerWorked = isPauseTimer.asDriver(onErrorDriveWith: .empty())
        
        timerText = totalTimerDuration
            .map { String("\(Double($0) / 10)")}
            .asDriver(onErrorDriveWith: .empty())
        
        isResetButtonHidden = Observable.merge(isTimerWorked.asObservable(), isResetButtonTaped.map { _ in true }.asObservable())
            .skip(1)
            .asDriver(onErrorDriveWith: .empty())
        
        isTimerWorked.asObservable()
            .flatMapLatest { [weak self] isWorked -> Observable<Int> in 
                if isWorked {
                    // RxTimeInterval：RxSwiftのコンテキストで時間間隔を表す型。
                    return Observable<Int>.interval(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
                        .withLatestFrom(Observable<Int>.just(self?.totalTimerDuration.value ?? 0)) { ($0 + $1)}
                } else {
                    return Observable<Int>.just(self?.totalTimerDuration.value ?? 0)
                }
            } 
            .bind(to: totalTimerDuration)
            .disposed(by: disposeBag)
        
        isResetButtonTaped.map { _ in 0 }
        .bind(to: totalTimerDuration)
        .disposed(by: disposeBag)
    }
}
