//
//  CustomLoginTextField.swift
//  MDFactory
//
//  Created by Виктор on 24/09/2022.
//

import UIKit

final class CustomLoginTextField: UITextField {
    // MARK: - Properties
    private let insets: UIEdgeInsets
    private let cornerRadius: CGFloat
    
    // MARK: - Initialize
    init(insets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                             left: 0,
                                             bottom: 0,
                                             right: 0),
         cornerRadius: CGFloat = 16) {
        self.insets = insets
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        
        setupView()
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
    private func setupView() {
        // border setup
        layer.cornerRadius = self.cornerRadius
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.2
    }
}
