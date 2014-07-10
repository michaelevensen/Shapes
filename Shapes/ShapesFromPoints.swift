//
//  ShapesFromPoints.swift
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

class ShapesFromPoints {
  
    init(pointsArray: [CGPoint]) {
        
        // pair
//        pairPoints(pointsArray)
        
        println( makeShapesFromPoints(pointsArray) )
    }
    
    func makeShapesFromPoints(points: [CGPoint]) -> [Shape] {
        
        var shapes = [Shape]()

        // checks for even and uneven numbers
        if points.count % 2 == 0 {

            for (index, point) in enumerate(points) {
                
                // for every second
                if (index + 1) % 2 == 0 {
                    
                    // make shape
                    shapes += Shape(points: (points[index-1], points[index]))
                }
            }
        }
        
        else {
            //
            println("Should return nil")
        }
        
        return shapes
    }
    
//    func pairPoints(points: [CGPoint]) -> [(CGPoint, CGPoint)] {
//        
//        var shapes = [Shape]()
//        
//        // checks for even and uneven numbers
//        if points.count % 2 == 0 {
//            
//            for (index, point) in enumerate(points) {
//                
//                // for every second
//                if index % 2 == 0 {
//                    
//                    shapes += Shape(fromPoints: (points[index-1], points[index]))
//                }
//            }
//        }
//        
//        else {
//            //
//            println("Should return nil")
//        }
//        
//        return [(CGPointZero, CGPointZero)] // temp
//    }
}
