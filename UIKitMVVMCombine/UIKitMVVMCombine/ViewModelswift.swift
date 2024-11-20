//
//  ViewModelswift.swift
//  UIKitMVVMCombine
//
//  Created by ごつ on 2024/11/17.
//

import UIKit
import Combine

final class ViewModel: ObservableObject {
    @Published var validationText = "idとpasswordを入力してください"
    @Published var validationColor = UIColor.black
    
    private let model: ModelProtocol
    
    init(model: ModelProtocol) {
        self.model = model
    }
    
    func idPasswordChanged(id: String?, password: String?) {
        let result = model.validate(idText: id, passwordText: password)
         
        switch result {
        case .success:
            validationText = "OK!!!"
            validationColor = .green
        case .failure(let error as ModelError):
            validationText = error.errorText
            validationColor = .red
        case _:
            fatalError("Unexpected pattern.")
        }
    }
}


extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .invalidIdAndPassword:
            return "IDとPasswordが未入力です。"
        case .invalidId:
            return "IDが未入力です。"
        case .invalidPassword:
            return "Passwordが未入力です。"
        }
    }
}
