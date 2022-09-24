//
//  CustomMainButton.swift
//  MDFactory
//
//  Created by Виктор on 20/09/2022.
//

import UIKit

class MainCustomButton: UIButton {
    // MARK: - Properties
    private var cornerRadius: CGFloat
    
    // MARK: - Initialize
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override method
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var brightnessFirst: CGFloat = 1
        var brightnessSecond: CGFloat = 0.95
        
        // when button pressed, overall button should become darker
        if state == .highlighted {
            brightnessFirst -= 0.1
            brightnessSecond -= 0.1
        }
        
        let outerColor = UIColor(hue: 252/360, saturation: 0.6, brightness: brightnessFirst, alpha: 1)
        let secondOuterColor =  UIColor(hue: 252/360, saturation: 0.79, brightness: brightnessSecond, alpha: 1)
        let shadowColor = UIColor(red: 0.186, green: 0.082, blue: 0.821, alpha: 0.1)
                
        let outerPath = createRoundedRectPath(for: rect, radius: 16)
        
        if state != .highlighted {
            context.saveGState()
            context.setFillColor(outerColor.cgColor)
            context.setShadow(offset: CGSize(width: 0, height: 3),
              blur: 3, color: shadowColor.cgColor)
            context.addPath(outerPath)
            context.fillPath()
            context.restoreGState()
          }
        
        context.saveGState()
        context.addPath(outerPath)
        context.clip()
        drawLinearGradient(context: context,
                           rect: rect,
                           startColor: outerColor.cgColor,
                           endColor: secondOuterColor.cgColor)
        context.restoreGState()
    }
    
    @objc func hesitateUpdate() {
      setNeedsDisplay()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      setNeedsDisplay()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesMoved(touches, with: event)
      setNeedsDisplay()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesCancelled(touches, with: event)
      setNeedsDisplay()
      
      perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      setNeedsDisplay()
      
      perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }
}
