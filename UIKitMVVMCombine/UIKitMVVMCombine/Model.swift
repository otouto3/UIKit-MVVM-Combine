//
//  Model.swift
//  UIKitMVVMCombine
//
//  Created by ごつ on 2024/11/17.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

protocol ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Result<Void>
}

struct Model: ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Result<Void> {
        switch (idText, passwordText) {
        case (.none, .none):
            return .failure(ModelError.invalidIdAndPassword)
        case (.none, .some):
            return .failure(ModelError.invalidId)
        case (.some, .none):
            return .failure(ModelError.invalidPassword)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true):
                return .failure(ModelError.invalidIdAndPassword)
            case (false, false):
                return .success(())
            case (true, false):
                return .failure(ModelError.invalidId)
            case (false, true):
                return .failure(ModelError.invalidPassword)
            }
        }
    }
}
