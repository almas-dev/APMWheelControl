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
    }

    func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let view: APMWheelControl = self.view as! APMWheelControl
        let touch: UITouch = touches.first!
        for sector: APMWheelSector in view.array {
            let touchPoint: CGPoint = touch.locationInView(sector)
            if CGPathContainsPoint(sector.arc.CGPath, nil, touchPoint, false) {
                print("Sector: \(sector.label)")
                let deltaAngle: CGFloat = -degreesToRadians(270) + atan2(view.transform.a, view.transform.b) + atan2(sector.transform.a, sector.transform.b)
                UIView.animateWithDuration(0.3, animations: {
                    view.transform = CGAffineTransformRotate(view.transform, deltaAngle)
                    print("Delta: \(Double(deltaAngle) / M_PI * 180)")
                }, completion: nil)
            }
        }
    }

    func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        //
    }

    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return CGFloat(M_PI * Double(degrees) / 180)
    }
}
