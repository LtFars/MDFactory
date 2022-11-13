//
//  FirebaseService.swift
//  MDFactory
//
//  Created by Vadim Kim on 11.10.2022.
//

import Foundation
import FirebaseAuth

class FirebaseService {

    static let shared = FirebaseService()

    private let user = Auth.auth().currentUser

    var userName: String {
        return user?.email ?? ""
    }

    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                if let errorCode = AuthErrorCode.Code(rawValue: error!._code) {
                    completion(.failure(errorCode))
                }
                return
            }
            completion(.success(true))
        }
    }

    func logOut(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }

    func deleteUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        user?.delete { error in
            guard error == nil else {
                if let errorCode = AuthErrorCode.Code(rawValue: error!._code) {
                    completion(.failure(errorCode))
                }
                return
            }

            completion(.success(true))
        }
    }

    func updatePassword(to password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        user?.updatePassword(to: password) { error in
            guard error == nil else {
                if let errorCode = AuthErrorCode.Code(rawValue: error!._code) {
                    completion(.failure(errorCode))
                }
                return
            }
            completion(.success(true))
        }
    }

    func sendMessageToResetPassword(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let email = user?.email else {
            let error = NSError(domain: "Ошибка с адресом электронной почты", code: -1)
            completion(.failure(error))
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                if let errorCode = AuthErrorCode.Code(rawValue: error!._code) {
                    completion(.failure(errorCode))
                }
                return
            }

            completion(.success(true))
        }
    }

}

// MARK: - AuthErrorCode.Code Description

extension AuthErrorCode.Code: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emailAlreadyInUse:
            return NSLocalizedString("Пользователь с таким email уже существует.", comment: "")
        case .userNotFound:
            return NSLocalizedString("Пользователя с таким email не существует.", comment: "")
        case .userDisabled:
            return NSLocalizedString("Ваш аккаунт заблокирован.\n Обратитесь в поддержку.", comment: "")
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return NSLocalizedString("Введите корректный email.", comment: "")
        case .networkError:
            return NSLocalizedString("Ошибка сети. Попробуйте позже.", comment: "")
        case .weakPassword:
            return NSLocalizedString("Пароль должен содержать не менее 6 символов.", comment: "")
        case .wrongPassword:
            return NSLocalizedString("Введён неверный неверный.", comment: "")
        case .requiresRecentLogin:
            return NSLocalizedString("Обновление пароля пользователя является важной операцией с точки зрения безопасности, для которой требуется недавний вход пользователя в систему. Требуется повторный вход в систему..", comment: "")
        default:
            return "Возникла непредвиденная ошибка"
        }
    }
}
