//
// Created by Xander on 24.02.16.
//

import UIKit

class APMWheelSector: UIView {

    var color: UIColor?
    var label: String? {
        didSet {
            sectorLabel.text = label
        }
    }
    let numberOfSegments: CGFloat = 5
    let lRadius: CGFloat
    let sRadius: CGFloat = 0
    var arc = UIBezierPath()
    private let sectorLabel = UILabel()

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(radius: CGFloat) {
        self.lRadius = radius

        func degreesToRadians(degrees: CGFloat) -> CGFloat {
            return CGFloat(M_PI * Double(degrees) / 180)
        }

        let sAngle = 270 - ((360 / numberOfSegments) / 2)
        let eAngle = 270 + ((360 / numberOfSegments) / 2)

        let startAngle = degreesToRadians(sAngle)
        let endAngle = degreesToRadians(eAngle)
        let lArc: UIBezierPath = UIBezierPath(arcCenter: CGPointMake(lRadius, lRadius), radius: lRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let sArc: UIBezierPath = UIBezierPath(arcCenter: CGPointMake(lRadius, lRadius), radius: sRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        var frame = CGRect()
        if (eAngle - sAngle) <= 180 {
            frame = CGRectMake(0, 0, lArc.bounds.width, sArc.currentPoint.y)
        }
        if (eAngle - sAngle) > 269 {
            frame = CGRectMake(0, 0, lArc.bounds.width, lArc.bounds.height)
        }

        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()

        sectorLabel.frame = CGRectMake(0, 0, frame.width, frame.height - 10)
        sectorLabel.textColor = UIColor.cyanColor()
        sectorLabel.textAlignment = .Center
        sectorLabel.transform = CGAffineTransformMakeRotation(degreesToRadians(90))
        addSubview(sectorLabel)
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        color?.setStroke()
        color?.setFill()

        let startAngle = degreesToRadians((270 - ((360 / numberOfSegments) / 2)))
        let endAngle = degreesToRadians((270 + ((360 / numberOfSegments) / 2)))
        let center = CGPointMake(CGRectGetMidX(rect), lRadius)
        arc = UIBezierPath(arcCenter: center, radius: lRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        arc.addArcWithCenter(center, radius: sRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        arc.closePath()
        arc.fill()
    }

    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return CGFloat(M_PI * Double(degrees) / 180)
    }
}
