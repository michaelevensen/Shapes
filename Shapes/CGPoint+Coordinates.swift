//
//  CGPoint+Coordinates.swift
//  Shapes
//
//  - Provides extra functionality for CGPoint to calculate
//  Angle, Distance and Center between two points
//
//  Created by Michael Nino Evensen on 7/3/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//
import UIKit

extension CGPoint {
    
    func angleToPoint(point: CGPoint) -> CGFloat {
        
        var deltaX = point.x - self.x
        var deltaY = point.y - self.y
        
        var angle = atan2(Double(deltaY), Double(deltaX)) // coordinates are flipped for SpriteKit
        
        return CGFloat(angle) * 180 / CGFloat(M_PI)
    }

    func distanceToPoint(point: CGPoint) -> CGFloat {
        
        var dx = self.x - point.x
        var dy = self.y - point.y
        
        var distanceX = dx*dx
        var distanceY = dy*dy
        
        var dxdy = Double(distanceX + distanceY)
        
        return CGFloat(sqrt(dxdy))
    }
    
    func midToPoint(point: CGPoint) -> CGPoint {

        var mx = (self.x + point.x) / 2
        var my = (self.y + point.y) / 2
        
        return CGPoint(x: mx, y: my)
    }
    
    func getInfoToPoint(point: CGPoint) -> (pointDistance: CGFloat, pointAngle: CGFloat, pointCenter: CGPoint) {
      
        return (self.distanceToPoint(point), self.angleToPoint(point), self.midToPoint(point))
    }
}