//
//  ShapesView.m
//  Shapes
//
//  Created by Michael Evensen on 5/1/14.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import "ShapesView.h"

@implementation ShapesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Init New ShapeLayer
        [self setShape: [[CAShapeLayer alloc] init]];
        
        // Styling
        self.shape.strokeColor = [UIColor redColor].CGColor;
        self.shape.fillColor = [UIColor redColor].CGColor;
        self.shape.lineWidth = 2.0;
        
        // Add ShapeLayer to View
        [[self layer] addSublayer:self.shape];
    }
    
    return self;
}

#pragma mark - Paths

// Detect if Point is in Path
- (BOOL)isPointInPath:(CGPoint)point
{
    return [self.path containsPoint:point];
}

// Make UIBezierPath from UITouch points
- (UIBezierPath *)makePathFromPoints:(NSSet *)points
{
    // Make new Bezier
//    [self setPath: [UIBezierPath bezierPath]];
//    
//    // Iterate through points
//    for (UITouch *touch in points) {
//        
//        // Get CGPoint
//        CGPoint point = [touch locationInView:nil];
//        
//        // Move to point for first point
//        if([self.path isEmpty]) {
//            
//            [self.path moveToPoint:point];
//        }
//        else {
//            
//            // Add line to point
//            [self.path addLineToPoint:point];
//        }
//    }
    
//    NSLog(@"%lu", (unsigned long)[points count]);
    
    // Close Path
//    if([points count]>2) {
//        [self.path closePath];
//    }
    
    // Assign Path to Shape
    [self.shape setPath:self.path.CGPath];
    
    return self.path;
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved: %@", self);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved: %@", self);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
