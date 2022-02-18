//
//  ViewController.swift
//  RxSwitStopwatch
//
//  Created by kobayashi on 2022/02/17.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let timerLabel: UILabel =  {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.font = UIFont.italicSystemFont(ofSize: 40)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let startStopButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black,for: .normal)
        button.layer.cornerRadius = 50
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Reset", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 50
        button.isHidden = true
        return button
    }()
    
    private var viewModel = StopWatchViewModelType
    private var disposeBag = DisposeBag()
    
    init(viewModel: StopWatchViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubView()
        bind()
        viewModel.inputs.ioPaueTimer.accept(false)
    }
}

