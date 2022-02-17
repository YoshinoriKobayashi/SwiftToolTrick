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
    var isTimerWorked: Driver<bool>
}
