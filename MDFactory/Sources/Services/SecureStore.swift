//
//  SecureStore.swift
//  MDFactory
//
//  Created by Vadim Kim on 10.10.2022.
//

import Foundation

class SecureStore {

    static func save(name: String, password: String) throws {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: name as AnyObject,
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

// MARK: - KeychainError

enum KeychainError: Error {
    case itemNotFound
    case duplicateItem
    case invalidItemFormat
    case unexpectedStatus(OSStatus)
}

// MARK: - KeychainError Description

extension KeychainError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .itemNotFound:
            return NSLocalizedString("Item not found", comment: "")
        case .duplicateItem:
            return NSLocalizedString("Trying to set existing item", comment: "")
        case .invalidItemFormat:
            return NSLocalizedString("Invalid item format", comment: "")
        case .unexpectedStatus(let status):
            return NSLocalizedString("Unexpected error \(status.description)", comment: "")
        }
    }
}
