//
//  WelcomeLabel.swift
//  MDFactory
//
//  Created by Виктор on 20/09/2022.
//

import UIKit

final class WelcomeLabel: UILabel {
   func getToWelcomeLabelText(firstPartOfText: String,
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
