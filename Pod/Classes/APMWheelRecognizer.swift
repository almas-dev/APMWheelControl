//
// Created by Xander on 26.02.16.
//

import UIKit

class APMWheelRecognizer: UIGestureRecognizer {

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(target: AnyObject?, action: Selector) {
        super.init(target: target, action: action)
    }

    /*func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let view: APMWheelControl = self.view as! APMWheelControl
        let touch = touches.first
        let point = touch.locationInView(view)
    }*/

    func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let view: APMWheelControl = self.view as! APMWheelControl
        let center: CGPoint = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
        let currentTouchPoint: CGPoint = touch!.locationInView(view)
        let previousTouchPoint: CGPoint = touch!.previousLocationInView(view)
        let angleInRadians = CGFloat(atan2f(Float(currentTouchPoint.y - center.y), Float(currentTouchPoint.x - center.x)) - atan2f(Float(previousTouchPoint.y - center.y), Float(previousTouchPoint.x - center.x)))
        view.transform = CGAffineTransformRotate(view.transform, angleInRadians)

        //print("A/B: \(view.transform.a)/\(view.transform.b)")
    }

    func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let view: APMWheelControl = self.view as! APMWheelControl

        for sector: APMWheelSector in view.array {
            //print("\(sector.label) A/B: \(sector.transform.a)/\(sector.transform.b)")

            let k: CGFloat = 0.809017
            let l: CGFloat = 0.587785
            if (sector.transform.b - k) ... (sector.transform.b + k) ~= -view.transform.a &&
                    (sector.transform.a - l) ... (sector.transform.a + l) ~= -view.transform.b {
                print("Sector: \(sector.label)")

                let deltaAngle: CGFloat = -degreesToRadians(270) + atan2(view.transform.a, view.transform.b) + atan2(sector.transform.a, sector.transform.b)

                UIView.animateWithDuration(0.3, animations: {
                    view.transform = CGAffineTransformRotate(view.transform, deltaAngle)
                }, completion: {
                    (finish: Bool) -> Void in
                    //
                })

            }
            /*let touch: UITouch = touches.first!
            let touchPoint: CGPoint = touch.locationInView(sector)
            if CGPathContainsPoint(sector.arc.CGPath, nil, touchPoint, false) {
                print("Sector: \(sector.label)")
                let deltaAngle: CGFloat = -degreesToRadians(270) + atan2(view.transform.a, view.transform.b) + atan2(sector.transform.a, sector.transform.b)
                print("Delta: \(Double(deltaAngle) / M_PI * 180)")
                print("Transform Before: A - \(view.transform.a) || B - \(view.transform.b)")
                UIView.animateWithDuration(0.3, animations: {
                    view.transform = CGAffineTransformRotate(view.transform, deltaAngle)
                }, completion: {
                    (finish: Bool) -> Void in
                    print("Transform After: A - \(view.transform.a) || B - \(view.transform.b)")
                    print("Sector: A - \(sector.transform.a) || B - \(sector.transform.b)")
                })
            }*/
        }
    }

    func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        //
    }

    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return CGFloat(M_PI * Double(degrees) / 180)
    }
}
