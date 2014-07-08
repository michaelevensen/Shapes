//
//  Rect.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 7/3/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import Foundation

class RectFromPoints {

    let rectSizeMin: CGFloat = 2.0
    let rectSizeMax: CGFloat = 400.0
    
    func fromPoints(pointA: CGPoint, pointB: CGPoint) -> CGRect {
        
        // get point info
        var pointInfo = getPointInfo(pointA, pb: pointB)
        
        // calculate height
        var height = max(rectSizeMin, rectSizeMax-pointInfo.distance/2)
        
        // Size
        var rectSize = CGSize(width: pointInfo.distance, height: height)
        
        /*
        *   Center, Scale and Transform
        *   - Note: The order of these are important:
        *       1. Set Default AffineTransformIdentity
        *       2. Size and Center
        *       3. New transform (in this case Rotation) is applied
        */
        
        // set new identity
        view.transform = CGAffineTransformIdentity
        
        // scale and set size
        view.frame.size = rectSize
        
        // center
        view.center = pointInfo.midPoint
        
        // rotate
        let transform = CGAffineTransformMakeRotation(degreesToRadians(pointInfo.angle));
        view.transform = transform;
        
        return rect
    }
    
    // get distance, angle and midpoint from two points
    func getPointInfo(pa: CGPoint, pb: CGPoint) -> (distance: CGFloat, angle: CGFloat, midPoint: CGPoint) {
        
        // find distance
        var distance = distanceBetweenPoints(pa, B: pb)
        
        // angle
        var angle = angleBetweenPoints(pa, B: pb)
        
        // midpoint (returns CGPoint)
        var midPoint = findMidPoint(pa, B: pb)
        
        return (distance, angle, midPoint)
    }
    
    // find rotation (in radians)
    func findRotation(transform: CGAffineTransform) -> CGFloat {
        
        return CGFloat(atan2f(Float(transform.b), Float(transform.a)))
    }
    
    // distance between points
    func distanceBetweenPoints(A: CGPoint, B: CGPoint) -> CGFloat {
        
        var dx = A.x - B.x
        var dy = A.y - B.y
        
        var distanceX = dx*dx
        var distanceY = dy*dy
        
        var dxdy = Double(distanceX + distanceY)
        
        return CGFloat(sqrt(dxdy))
    }
    
    // degrees to radians
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        
        return degrees * CGFloat(M_PI) / 180
    }
    
    // find mid point between two points
    func findMidPoint(A: CGPoint, B: CGPoint) -> CGPoint {
        
        var midPointX = (A.x + B.x) / 2
        var midPointY = (A.y + B.y) / 2
        
        return CGPoint(x: midPointX, y: midPointY)
    }
    
    // in radians
    func angleBetweenPoints(A: CGPoint, B: CGPoint) -> CGFloat {
        
        var deltaX = B.x - A.x
        var deltaY = B.y - A.y
        
        var angle = atan2(Double(deltaY), Double(deltaX))
        
        // Angle
        return CGFloat(angle) * 180 / CGFloat(M_PI)
    }
}