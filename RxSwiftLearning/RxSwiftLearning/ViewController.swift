//
//  ViewController.swift
//  RxSwiftLearning
//
//  Created by Swift-Beginners on 2021/03/01.
//

import RxSwift
import RxCoCoa

class SimpleRxTapViewController:UIViewController {
    @IBOutlet weak var loginButton:UIButton!
    @IBOutlet weak var resetPasswordButton:UIButton!
    @IBOutlet weak var exitButton:UIButton!
    @IBOutlet weak var helpButton:UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.rx.tap
            .subscribe(onNext:{[weak self] in
                self?.messageLabel.text = "Tap Login Button!"
            })
            .disposed(by: disposeBag)
        
        resetPasswordButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.messageLabel.text = "Tap Reset Password Button!"
            })
            .disposed(by: disposeBag)
        
        exitButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.messageLabel.text = "Tap Exit Button!"
            })
            .disposed(by:disposeBag)
        
        helpButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.messageLabel.text = "Tap Help Button!"
            })
            .disposed(by: disposeBag)
    }
    
}

