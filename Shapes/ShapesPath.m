//
//  ShapesPath.m
//  Shapes
//
//  Created by Michael Evensen on 4/18/14.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import "ShapesPath.h"

@implementation ShapesPath

/*
 * Detect if Point is in Path
 */
- (BOOL)isPointInPath:(CGPoint)point
{
    return [self.path containsPoint:point];
}

/*
 * Make UIBezierPath from UITouch points
 */
- (UIBezierPath *)makePathFromPoints:(NSArray *)points
{
    // Make new Bezier
    self.path = [UIBezierPath bezierPath];
    
    // Iterate through points
    for (UITouch *touch in points) {
    
        // Get CGPoint
        CGPoint point = [touch locationInView:nil];
    
        // Move to point for first point
        if([self.path isEmpty]) {
    
            [self.path moveToPoint:point];
        }
        else {
            
            // Add line to point
            [self.path addLineToPoint:point];
        }
    }
    
    return self.path;
}

@end
