//
//  SecureStore.swift
//  MDFactory
//
//  Created by Vadim Kim on 10.10.2022.
//

import Foundation

class SecureStore {

    //to be deleted after merge MDF-9
    /// Save user's password to secure storage
    /// - Parameters:
    ///   - userName: user's name
    ///   - password: password to save
    static func save(userName: String, password: String) throws {
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

    //to be deleted after merge MDF-9
    /// Read user's password from secure storage
    /// - Parameters:
    ///   - userName: user's name
    static func readPassword(userName: String) throws -> String {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }

        guard let data = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
        }

        let password = String(decoding: data, as: UTF8.self)

        return password
    }

    /// Delete user's password from secure storage
    /// - Parameters:
    ///   - userName: user's name
    static func deletePassword(userName: String) throws {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
