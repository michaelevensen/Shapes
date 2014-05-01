//
//  ShapesPath.h
//  Shapes
//
//  Created by Michael Evensen on 4/18/14.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShapesPath : NSObject

- (UIBezierPath *)makePathFromPoints:(NSArray *)points;
- (BOOL)isPointInPath:(CGPoint)point;

@property UIBezierPath *path;

@end
