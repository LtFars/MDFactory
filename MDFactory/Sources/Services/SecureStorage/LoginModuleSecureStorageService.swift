//
//  LoginModuleSecureStorageService.swift
//  MDFactory
//
//  Created by Vadim Kim on 21.11.2022.
//

import Foundation

protocol LoginModuleSecureStorageServiceType {
    func isExists(userName: String) throws -> Bool
    func save(userName: String, password: String) throws
}

class LoginModuleSecureStorageService: LoginModuleSecureStorageServiceType {

    /// Check user's password existense in secure storage
    /// - Parameters:
    ///   - userName: user's name
    func isExists(userName: String) throws -> Bool {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemCopyMatching(query as CFDictionary, nil)

        switch status {
        case errSecSuccess, errSecInteractionNotAllowed:
            return true
        case errSecItemNotFound:
            return false
        default:
            throw KeychainError.unexpectedStatus(status)
        }
    }

    /// Save user's password to secure storage
    /// - Parameters:
    ///   - userName: user's name
    ///   - password: password to save
    func save(userName: String, password: String) throws {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: Data(password.utf8) as AnyObject
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
