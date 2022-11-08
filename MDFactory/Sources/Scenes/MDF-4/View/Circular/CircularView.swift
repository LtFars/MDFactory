//
//  ProgressView.swift
//  MDFactory
//
//  Created by Andrei Maskal on 05/09/2022.
//

import UIKit

class CircularView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let rectCircular = CGRect(x: 0, y: 0, width: rect.width / 2, height: rect.height / 2)
        let dotAngle = CGRect(x: 0, y: 0, width: rect.width / 2, height: rect.height / 2)
        
        drawCircular(rectCircular)
        drawDot(dotAngle)
        
    }
    
    func drawCircular(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.width, y: rect.height)
        let radius = rect.width
        
        let pathRed = UIBezierPath(arcCenter: center,
                                   radius: radius,
                                   startAngle: 3 * CGFloat.pi / 2,
                                   endAngle: 0,
                                   clockwise: true)
        
        let pathBlue = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: 0,
                                    endAngle: CGFloat.pi / 3,
                                    clockwise: true)
        
        let pathGreen = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: CGFloat.pi / 3,
                                     endAngle: 5 * CGFloat.pi / 6,
                                     clockwise: true)
        
        let pathGray = UIBezierPath(arcCenter: center,
                                    radius: radius - 22,
                                    startAngle: 0,
                                    endAngle: 2 * CGFloat.pi,
                                    clockwise: true)
        
        let circulareRed = CAShapeLayer()
        circulareRed.lineWidth = 30
        circulareRed.strokeColor = Color.red.color.cgColor
        circulareRed.fillColor = UIColor.clear.cgColor
        circulareRed.lineCap = .round
        circulareRed.path = pathRed.cgPath
        
        let circulareBlue = CAShapeLayer()
        circulareBlue.lineWidth = 30
        circulareBlue.strokeColor = Color.blue.color.cgColor
        circulareBlue.fillColor = UIColor.clear.cgColor
        circulareBlue.lineCap = .round
        circulareBlue.path = pathBlue.cgPath
        
        let circulareGreen = CAShapeLayer()
        circulareGreen.lineWidth = 30
        circulareGreen.strokeColor = Color.green.color.cgColor
        circulareGreen.fillColor = UIColor.clear.cgColor
        circulareGreen.lineCap = .round
        circulareGreen.path = pathGreen.cgPath
        
        let circulareGray = CAShapeLayer()
        circulareGray.lineWidth = 14
        circulareGray.strokeColor = Color.gray.color.cgColor
        circulareGray.fillColor = UIColor.clear.cgColor
        circulareGray.lineCap = .round
        circulareGray.path = pathGray.cgPath
        
        layer.addSublayer(circulareGreen)
        layer.addSublayer(circulareBlue)
        layer.addSublayer(circulareRed)
        layer.addSublayer(circulareGray)
        
    }
    
    func drawDot(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.width, y: 0)
        let radius = rect.width / 10
        let dot = UIBezierPath(arcCenter: center,
                               radius: radius,
                               startAngle: 0,
                               endAngle: 2 * CGFloat.pi,
                               clockwise: true)
        
        
        let dotRed = CAShapeLayer()
        dotRed.lineWidth = 4
        dotRed.strokeColor = Color.redDark.color.cgColor
        dotRed.fillColor = Color.redDark.color.cgColor
        dotRed.path = dot.cgPath
        
        layer.addSublayer(dotRed)
    }
}

