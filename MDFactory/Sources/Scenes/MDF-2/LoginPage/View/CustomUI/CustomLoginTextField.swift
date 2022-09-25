//
//  CustomLoginTextField.swift
//  MDFactory
//
//  Created by Виктор on 24/09/2022.
//

import UIKit
import SnapKit

final class CustomLoginTextField: UITextField {
    // MARK: - Properties
    private let insets: UIEdgeInsets
    private let cornerRadius: CGFloat
    private let secureTextMode: Bool
    
    // MARK: - Views
    private let label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private let textEntryModeSwitchButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "eye.slash")?.withRenderingMode(.alwaysOriginal)
        
        button.contentMode = .center
        
        button.setImage(image?.withTintColor(.lightGray), for: .normal)
        button.setImage(image?.withTintColor(.gray), for: .selected)
        button.addTarget(CustomLoginTextField.self,
                         action: #selector(secureEntryModeSwitcher),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initialize
    init(insets: UIEdgeInsets = UIEdgeInsets(top: 16,
                                             left: 25,
                                             bottom: 0,
                                             right: 20),
         cornerRadius: CGFloat = 16,
         labelText: String,
         secureTextMode: Bool = false) {
        self.insets = insets
        self.cornerRadius = cornerRadius
        self.label.text = labelText
        self.secureTextMode = secureTextMode
        super.init(frame: .zero)
                
        setupHierarchy()
        setupLayout()
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
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let topInset: CGFloat = 0
        let rightInset: CGFloat = insets.right
        let bottomInset: CGFloat = 0
        let leftInset: CGFloat = bounds.width - insets.right - 26.33
        
        let buttonInsets = UIEdgeInsets(top: topInset,
                                        left: leftInset,
                                        bottom: bottomInset,
                                        right: rightInset)
        return bounds.inset(by: buttonInsets)
    }
    
    // MARK: - Methods
    private func setupHierarchy() {
        addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(8)
        }
    }
    
    private func setupView() {
        // border setup
        layer.cornerRadius = self.cornerRadius
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.2
        
        //font setup
        font = UIFont.systemFont(ofSize: 15)
        
        //security mode
        isSecureTextEntry = secureTextMode
        if secureTextMode {
            rightView = textEntryModeSwitchButton
            rightViewMode = .always
        }
    }
    
    @objc func secureEntryModeSwitcher() {
        textEntryModeSwitchButton.isSelected.toggle()
            if textEntryModeSwitchButton.state == .normal {
                self.isSecureTextEntry = true
            } else if textEntryModeSwitchButton.state == .selected {
                self.isSecureTextEntry = false
            }
        print(#function)
    }
}
