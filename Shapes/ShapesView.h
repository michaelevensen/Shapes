//
//  ShapesView.h
//  Shapes
//
//  Created by Michael Evensen on 5/1/14.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShapesView : UIView

@property UIBezierPath *path;
@property CAShapeLayer *shape;

// Paths
- (BOOL)isPointInPath:(CGPoint)point;
- (UIBezierPath *)makePathFromPoints:(NSArray *)points;

@end
