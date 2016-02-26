//
// Created by Xander on 24.02.16.
//

import UIKit
import CoreGraphics

public class APMWheelControl: UIControl {

    let numberOfSegments = 5
    var array = [APMWheelSector]()
    let wheelColor = UIColor.magentaColor()
    var wheel = UIBezierPath()

    required public init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        let recognizer = APMWheelRecognizer()
        addGestureRecognizer(recognizer)

        backgroundColor = UIColor.yellowColor()

        for i in 0..<numberOfSegments {
            let sector = APMWheelSector(radius: frame.width / 2)
            sector.color = UIColor(white: 0.15 * CGFloat(i + 1), alpha: 1.0)
            sector.label = "Open\(i)"
            array.append(sector)
        }
    }

    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)

        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextSetBlendMode(context, CGBlendMode.Copy)
        wheelColor.setFill()
        wheel = UIBezierPath(ovalInRect: rect)
        wheel.closePath()
        wheel.fill()
        CGContextRestoreGState(context)

        let sectorSize: CGFloat = 360 / CGFloat(numberOfSegments)
        var sectorDegrees: CGFloat = 180
        let center = CGPointMake(rect.width / 2, rect.height / 2)
        for i in 0..<numberOfSegments {
            let sector = array[i]
            let radius = rect.height / 4
            let x = center.x + (radius * cos(degreesToRadians(sectorDegrees)))
            let y = center.y + (radius * sin(degreesToRadians(sectorDegrees)))
            sector.transform = CGAffineTransformMakeRotation(degreesToRadians((sectorDegrees + 90)))
            sector.layer.position = CGPointMake(x, y)
            sectorDegrees += sectorSize
            addSubview(sector)

            print("Position: \(x) - \(y)");
        }
    }

    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return CGFloat(M_PI * Double(degrees) / 180)
    }
}
