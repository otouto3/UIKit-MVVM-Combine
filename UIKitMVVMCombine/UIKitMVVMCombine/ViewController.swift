//
//  ViewController.swift
//  UIKitMVVMCombine
//
//  Created by ごつ on 2024/11/17.
//

import UIKit
import SnapKit
import Combine

class ViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = ViewModel(model: Model())
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
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        return $0
    }(UIStackView(arrangedSubviews: [idTextField, passwordTextField]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBinding()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(validationLabel)
         
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        validationLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupBinding() {
        idTextField.addTarget(
            self,
            action: #selector(textFieldEditingChanged),
            for: .editingChanged
        )
        
        passwordTextField.addTarget(
            self,
            action: #selector(textFieldEditingChanged),
            for: .editingChanged
        )
        
        viewModel.$validationText
            .compactMap {$0}
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: validationLabel)
            .store(in: &cancellables)
        
        viewModel.$validationColor
              .receive(on: RunLoop.main)
              .assign(to: \.textColor, on: validationLabel)
              .store(in: &cancellables)
    }
    
    @objc func textFieldEditingChanged(sender: UITextField) {
        viewModel.idPasswordChanged(
            id: idTextField.text,
            password: passwordTextField.text
        )
    }
}

