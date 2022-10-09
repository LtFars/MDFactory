//
//  UIViewExtensionWithCoreData.swift
//  MDFactory
//
//  Created by Виктор on 20/09/2022.
//

import UIKit
import CoreGraphics

extension UIView {
    /// Make views rounded layer
    /// - Parameters:
    ///   - rect: views rect
    ///   - radius: arcs radius
    /// - Returns: layer(CGMutablePAth)
    func createRoundedRectPath(for rect: CGRect,
                               radius: CGFloat) -> CGMutablePath {
        let path = CGMutablePath()
        let midTopPoint = CGPoint(x: rect.midX, y: rect.minY)
        path.move(to: midTopPoint)
        let topRightPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRightPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeftPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let topLeftPoint = CGPoint(x: rect.minX, y: rect.minY)
        path.addArc(tangent1End: topRightPoint,
                    tangent2End: bottomRightPoint,
                    radius: radius)
        path.addArc(tangent1End: bottomRightPoint,
                    tangent2End: bottomLeftPoint,
                    radius: radius)
        path.addArc(tangent1End: bottomLeftPoint,
                    tangent2End: topLeftPoint,
                    radius: radius)
        path.addArc(tangent1End: topLeftPoint,
                    tangent2End: topRightPoint,
                    radius: radius)
        path.closeSubpath()
        return path
    }
    
    func drawLinearGradient(context: CGContext,
                            rect: CGRect,
                            startColor: CGColor,
                            endColor: CGColor) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let colors: CFArray = [startColor, endColor] as CFArray
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors,
                                  locations: colorLocations)!
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        context.saveGState()
        context.addRect(rect)
        context.clip()
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        context.restoreGState()
    }
}
