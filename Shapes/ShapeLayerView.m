//
//  ShapeLayerView.m
//  Shapes
//
//  Created by Rnald on 03/05/2014.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import "ShapeLayerView.h"
#import "PathGestureRecognizer.h"

@interface ShapeLayerView()
@property (nonatomic) CAShapeLayer *currentShapeLayer;
@end

@implementation ShapeLayerView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initShapeLayerView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initShapeLayerView];
    }
    return self;
}

- (void)initShapeLayerView
{
    PathGestureRecognizer *recognizer = [[PathGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self addGestureRecognizer:recognizer];
}

#pragma mark - Actions

- (void)handleGesture:(PathGestureRecognizer *)recognizer
{
    switch ([recognizer state]) {
        case UIGestureRecognizerStateBegan:
            self.currentShapeLayer = [self createShapeLayer];
            [self.layer addSublayer:self.currentShapeLayer];
            break;

        case UIGestureRecognizerStateChanged:
            self.currentShapeLayer.path = recognizer.touchPath.CGPath;
            break;

        case UIGestureRecognizerStateEnded:
            self.currentShapeLayer = nil;
            break;

        case UIGestureRecognizerStateCancelled:
            [self.currentShapeLayer removeFromSuperlayer];
            self.currentShapeLayer = nil;
            break;

        default:
            break;
    }
}

#pragma mark - Private

- (CAShapeLayer *)createShapeLayer
{
    NSArray *colors = @[ [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor] ];
    UIColor *color = colors[rand() % [colors count]];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.lineWidth = 5;
    return shapeLayer;
}

@end
