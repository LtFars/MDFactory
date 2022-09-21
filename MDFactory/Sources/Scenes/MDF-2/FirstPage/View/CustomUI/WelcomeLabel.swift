//
//  WelcomeLabel.swift
//  MDFactory
//
//  Created by Виктор on 20/09/2022.
//

import UIKit

final class WelcomeLabel: UILabel {
    // MARK: - Initialize
    init(firstPartOfText: String,
         secondPartOfText: String,
         fontSize: CGFloat) {
        super.init(frame: .zero)
        self.getToWelcomeLabelText(firstPartOfText: firstPartOfText,
                                   secondPartOfText: secondPartOfText,
                                   fontSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    /// The method is designed to display the main text in the form of a bold first part and a regular second
    /// - Parameters:
    ///   - firstPartOfText: first part of text
    ///   - secondPartOfText: second part of text
    ///   - fontSize: size of text
    private func getToWelcomeLabelText(firstPartOfText: String,
                                       secondPartOfText: String,
                                       fontSize: CGFloat) {
        let attributedText = NSMutableAttributedString()
        let firstPart = NSAttributedString(string: firstPartOfText,
                                           attributes: [NSAttributedString.Key.font: UIFont(name: "RedHatDisplay-Bold",
                                                                                            size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)])
        let secondPart = NSAttributedString(string: secondPartOfText,
                                            attributes: [NSAttributedString.Key.font: UIFont(name: "RedHatDisplay",
                                                                                             size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)])
        
        attributedText.append(firstPart)
        attributedText.append(secondPart)
        
        self.attributedText = attributedText
    }
}
