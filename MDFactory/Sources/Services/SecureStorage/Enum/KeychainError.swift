//
//  KeychainError.swift
//  MDFactory
//
//  Created by Vadim Kim on 22.11.2022.
//

import Foundation

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
