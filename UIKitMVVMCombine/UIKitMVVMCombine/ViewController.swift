//
//  ViewController.swift
//  UIKitMVVMCombine
//
//  Created by ごつ on 2024/11/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let idTextField = UITextField()
    private let passwordTextField = UITextField()
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
         
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

