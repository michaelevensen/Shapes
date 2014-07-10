//
//  ShapesFromTouches.swift
//  Shapes
//
//  This class works like this:
//  A. Takes an NSSet of UITouch (derived from touchesBegan or touchesMoved)
//  B. Sorts the touches by timestamp
//  C. Creates Shapes (Shape.swift) based on pairs of two touches
//  D. Returns Array of Shapes
// 
//  - Returns an array of Shapes. If the amount of touches sent is uneven returns nil.
//
//  Created by Michael Nino Evensen on 7/10/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import UIKit

class ShapesFromTouches {
    
    var nodeSizeMin: CGFloat = 20.0
    var nodeSizeMax: CGFloat = 500.0
    
    init(touches: NSSet!) {
        
        
    
    }
    
    func makeShapeFromPoints(a: CGPoint, b: CGPoint) -> Shape {
        
        // get point info
        var info = a.getInfoToPoint(b)
        
        // find size based on points
        var size = CGSize(width: info.pointDistance, height: max(nodeSizeMin, nodeSizeMax-info.pointDistance))
        
        return Shape(size: size, position: info.mid, angle: info.pointAngle.toRadians())
    }
}
