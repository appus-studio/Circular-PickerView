//
//  AppusCircularPickerView.swift
//  CircularPickerViewSwift
//
//  Created by Sergey Sokoltsov on 12/14/16.
//  Copyright © 2016 Sergey Sokoltsov. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class AppusCircularPickerView: UIControl {
    @IBInspectable public var lineColor: UIColor?
    @IBInspectable public var bgColor: UIColor?
    @IBInspectable public var lineWidth: Float = 0 {
        didSet(newValue) {
            setNeedsDisplay()
        }
    }
    @IBInspectable public var minValue: NSInteger = 0
    @IBInspectable public var maxValue: NSInteger = 0
    @IBInspectable public var defaultValue: NSInteger = 0
    @IBInspectable public var step: NSInteger = 0
    @IBInspectable public var autocomplete: Bool = true

    public var currentValue: Float = 0

    var angle: Float = 0 {
        didSet(newValue) {
            setNeedsDisplay()
        }
    }

    var coef: Float = 0

    // MARK: Touches

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let point = pointFromTouches(touches)
        let currentAngle = angleFromPoint(point)
        processNewAngle(currentAngle)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let point = pointFromTouches(touches)
        let currentAngle = angleFromPoint(point)
        processNewAngle(currentAngle)
    }

    // MARK: Self methods

    func processNewAngle(_ newAngle: Float) {
        var currentAngle = newAngle
        if autocomplete {
            currentAngle = autocompleteAngle(angle: currentAngle);
        }
        angle = currentAngle
        currentValue = getCurrentValue()
        sendActions(for: UIControlEvents.valueChanged)
    }

    func autocompleteAngle(angle: Float) -> Float {
        let degreesPerStep = 360 / ((labs(minValue) + labs(maxValue)) / step)
        let minStepValue = Int(angle) / degreesPerStep
        let maxStepValue = minStepValue + 1
        let dMin = Int(angle) - (minStepValue * degreesPerStep);
        let dMax = (maxStepValue * degreesPerStep) - Int(angle);
        return Float(dMin < dMax ? minStepValue * degreesPerStep : maxStepValue * degreesPerStep)
    }

    func getCurrentValue() -> Float {
        if autocomplete {
            return Float(NSInteger(angle * coef) + minValue)
        } else {
            return (angle * coef) + Float(minValue) // if min value differs from 0 we should cobsider
        }
    }

    func pointFromTouches(_ touches: Set<UITouch>) -> CGPoint {
        let touch = touches.first
        return touch!.location(in: self)
    }

    func angleFromPoint(_ point: CGPoint) -> Float {
        let degrees = RADIANS_TO_DEGREES(radiansFromPoint(point))
        return degrees > 0.0 ? (360.0 - degrees) : -degrees
    }

    func RADIANS_TO_DEGREES(_ radians: Float) -> Float {
        return ((radians) * 180.0 / Float(M_PI))
    }

    func DEGREES_TO_RADIANS(_ angle: Float) -> Float {
        return ((angle) / 180.0 * Float(M_PI))
    }

    func radiansFromPoint(_ point: CGPoint) -> Float {
        let defaultVector = CGPoint(x: 0, y: -1)
        return Float(atan2(defaultVector.y, defaultVector.x)) - Float(atan2(point.y - self.bounds.size.height / 2, point.x - self.bounds.size.width / 2))
    }

    func getArcRadius() -> CGFloat {
        return min(self.bounds.width / 2, self.bounds.height / 2) - CGFloat(lineWidth)
    }

    // MARK: Drawing

    func drawBackgroundArc() {
        drawArcWithRadius(radius: getArcRadius(), endAngle: 360.0, lineWidth: CGFloat(lineWidth), lineColor: bgColor!)
    }

    func drawActiveArc() {
        drawArcWithRadius(radius: getArcRadius(), endAngle: CGFloat(angle), lineWidth: CGFloat(lineWidth), lineColor: lineColor!)
    }

    func drawArcWithRadius(radius: CGFloat, endAngle: CGFloat, lineWidth: CGFloat, lineColor: UIColor) {
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(lineWidth)
        context?.setFillColor(red: 0, green: 0, blue: 0, alpha: 0)
        context?.setLineCap(CGLineCap.butt)
        context?.setStrokeColor(lineColor.cgColor)

        context?.addArc(center: center, radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI_2) + CGFloat(DEGREES_TO_RADIANS(Float(endAngle))), clockwise: false)
        context?.strokePath()
    }

    // MARK: lifecycle

    override public func awakeFromNib() {
        super.awakeFromNib()
        coef = Float(maxValue - minValue) / 360.0 // part of sector in one degrees
        angle = Float(defaultValue - minValue) / coef
        if step == 0 {
            step = step + 1
        }
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        drawBackgroundArc()
        drawActiveArc()
    }

}
