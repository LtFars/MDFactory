//
//  ColorView.swift
//  MDFactory
//
//  Created by Andrei Maskal on 09/09/2022.
//

import UIKit

enum Color {
    case red
    case blue
    case green
    case gray
    case redDark
    
    var color: UIColor {
        
        switch self {
        case .red:
            return #colorLiteral(red: 1, green: 0.2549019608, blue: 0.5215686275, alpha: 1)
        case .gray:
            return #colorLiteral(red: 0.9411764706, green: 0.9529411765, blue: 0.9803921569, alpha: 1)
        case .blue:
            return #colorLiteral(red: 0.04705882353, green: 0.6509803922, blue: 0.9921568627, alpha: 1)
        case .green:
            return #colorLiteral(red: 0.07450980392, green: 0.9450980392, blue: 0.662745098, alpha: 1)
        case .redDark:
            return #colorLiteral(red: 0.8705882353, green: 0.231372549, blue: 0.1960784314, alpha: 1)
        }
    }
}
