//
//  ViewController.swift
//  RxSwiftUITextField
//
//  Created by kobayashi on 2022/02/24.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タップ
        let gesture = UITapGestureRecognizer()
        view.addGestureRecognizer(gesture)
        
        // 画面タップ
        gesture.rx.event.asDriver()
            .debug("event")
            .drive(onNext: {[unowned self] event in
                print("tap event:\(event)")
                self.view.endEditing(true)
                
            })
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.asDriver()
            .debug("orEmpty")
            .drive(onNext: {[unowned self] text in
                print("text:\(text)")
                print("isEditing:\(self.textField.isEditing)")
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidBegin).asDriver()
            .debug("editingDidBegin")
            .drive(onNext: { _ in
                print("editingDidBegin")
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingChanged).asDriver()
            .debug("editingChanged")
            .drive(onNext: { _ in
                print("editingChanged")
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEnd).asDriver()
            .debug("editingDidEnd")
            .drive(onNext: { _ in
                print("editingDidEnd")
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .debug("editingDidEndOnExit")
            .drive(onNext: { _ in
                print("editingDidEndOnExit")
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.valueChanged).asDriver()
            .debug("valueChanged")
            .drive(onNext: { _ in
                print("valueChanged")
            })
            .disposed(by: disposeBag)
        
        button.rx.tap.asDriver()
            .debug("button")
            .drive(onNext: { [unowned self] _ in
                print("button tapped")
                self.textField.text = "button"
            })
            .disposed(by: disposeBag)
        
        button2.rx.tap.asDriver()
            .debug("button2")
            .drive(onNext: { [unowned self] _ in
                print("button2 tapped")
                self.textField.text = "button2"
                self.textField.sendActions(for: .valueChanged)
            })
            .disposed(by: disposeBag)
        
    }
    
    
    
}

