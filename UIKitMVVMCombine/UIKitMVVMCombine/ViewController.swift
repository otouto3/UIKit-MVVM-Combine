//
//  ViewController.swift
//  UIKitMVVMCombine
//
//  Created by ごつ on 2024/11/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let idTextField = {
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())
    
    private let passwordTextField = {
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())
    
    private let validationLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18)
        return $0
    }(UILabel())
    
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        return $0
    }(UIStackView(arrangedSubviews: [idTextField, passwordTextField]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(validationLabel)
         
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        validationLabel.snp.makeConstraints {
            $0.top.equalTo(stackView).offset(16)
        }
    }
}

