//
//  GestureRecognizerSheetView.swift
//  MDFactory
//
//  Created by Andrei Maskal on 13/09/2022.
//

import UIKit

class GestureRecognizerSheetView: UIView {
    
//     Lifecycle
        override init(frame: CGRect) {
            super.init(frame: frame)
            recognizerView()
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    var sheetImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
        imageView.layer.cornerRadius = 40
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var stripImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9019607843, blue: 0.9529411765, alpha: 1)
        
        return imageView
    }()
    
    func recognizerView() {
        let gestureRecognizerView = UITapGestureRecognizer(target: self, action: #selector(swipeSheet))
        gestureRecognizerView.numberOfTapsRequired = 2
        gestureRecognizerView.numberOfTouchesRequired = 1
        sheetImageView.addGestureRecognizer(gestureRecognizerView)
        sheetImageView.isUserInteractionEnabled = true
        
    }
    @objc func swipeSheet() {
       sheetImageView.backgroundColor = .red
            print("Tap")
        
    }
    
}
