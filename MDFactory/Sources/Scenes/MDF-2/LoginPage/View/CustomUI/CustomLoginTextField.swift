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
        label.font = UIFont.systemFont(ofSize: Metrics.labelTextSize)
        return label
    }()
    
    private let textEntryModeSwitchButton: UIButton = {
        let button = UIButton()
        let imageNormal = UIImage(systemName: "eye.slash")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let imageSelect = UIImage(systemName: "eye")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        button.contentMode = .center
        button.setImage(imageNormal, for: .normal)
        button.setImage(imageSelect, for: .selected)
        button.addTarget(CustomLoginTextField.self,
                         action: #selector(secureEntryModeSwitcher),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialize
    
    init(insets: UIEdgeInsets = Metrics.textFieldsEdgeInsets,
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
        let leftInset: CGFloat = bounds.width - insets.right - 26
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
            make.leading.equalToSuperview().inset(Metrics.lableLeadingInset)
            make.top.equalToSuperview().inset(Metrics.lableTopInset)
        }
    }
    
    private func setupView() {
        // border setup
        layer.cornerRadius = self.cornerRadius
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.2
        
        //font setup
        font = UIFont.systemFont(ofSize: Metrics.textFieldsTextSize)
        
        //security mode
        isSecureTextEntry = secureTextMode
        if secureTextMode {
            rightView = textEntryModeSwitchButton
            rightViewMode = .always
        }
    }
    
    @objc func secureEntryModeSwitcher() {
        textEntryModeSwitchButton.isSelected.toggle()
        DispatchQueue.main.async {
            if self.textEntryModeSwitchButton.state == .normal {
                self.isSecureTextEntry = true
            } else if self.textEntryModeSwitchButton.state == .selected {
                self.isSecureTextEntry = false
            }
        
        }
    }
}

extension CustomLoginTextField {
    enum Metrics {
        static let labelTextSize: CGFloat = 12 * UIScreen.main.bounds.height / 812
        
        static let textFieldsTextSize: CGFloat = 15 * UIScreen.main.bounds.height / 812
        
        static let textFieldsEdgeInsets = UIEdgeInsets(top: 16 * UIScreen.main.bounds.height / 812,
                                                       left: 25 * UIScreen.main.bounds.width / 375,
                                                       bottom: 0,
                                                       right: 20 * UIScreen.main.bounds.width / 375)
        static let lableLeadingInset: CGFloat = 25 * UIScreen.main.bounds.height / 812
        static let lableTopInset: CGFloat = 10 * UIScreen.main.bounds.height / 812
    }
}
