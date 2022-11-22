//
//  SettingsModuleSecureStorageService.swift
//  MDFactory
//
//  Created by Vadim Kim on 22.11.2022.
//

import Foundation

protocol SettingsModuleSecureStorageServiceType {
    func readPassword(userName: String) throws -> String
    func updatePassword(userName: String, to newPassword: String) throws
}

class SettingsModuleSecureStorageService: SettingsModuleSecureStorageServiceType {

    /// Read user's password from secure storage
    /// - Parameters:
    ///   - userName: user's name
    func readPassword(userName: String) throws -> String {
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

    /// Update user's password to secure storage, if the one exists
    /// - Parameters:
    ///   - userName: user's name
    func updatePassword(userName: String, to newPassword: String) throws {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        let attributes: [String: AnyObject] = [
            kSecValueData as String: Data(newPassword.utf8) as AnyObject
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
