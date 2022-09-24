//
//  CustomLoginTextField.swift
//  MDFactory
//
//  Created by Виктор on 24/09/2022.
//

import UIKit

final class CustomLoginTextField: UITextField {
    // MARK: - Properties
    let insets: UIEdgeInsets
    
    // MARK: - Initialize
    init(insets: UIEdgeInsets, cornerRadius: CGFloat) {
        self.insets = insets
        super.init(frame: .zero)
        
        layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriding methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    // MARK: - Methods
    
}
