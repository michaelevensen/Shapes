//
//  PathGestureRecognizer.m
//  Shapes
//
//  Created by Rnald on 03/05/2014.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import "PathGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface PathGestureRecognizer()
@property (nonatomic, readwrite) UIBezierPath *touchPath;
@property (nonatomic) NSTimer *delayTimer;
@end

@implementation PathGestureRecognizer

#pragma mark - Constants

static const NSTimeInterval kDelayTimerDuration = 0.2;

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateStateWithTouches:[event allTouches]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delayTimer == nil || ![self.delayTimer isValid]) {
        [self updateStateWithTouches:[event allTouches]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *remainingTouches = [self setByRemovingSet:touches fromSet:[event allTouches]];
    [self delayUpdateWithTouches:remainingTouches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *remainingTouches = [self setByRemovingSet:touches fromSet:[event allTouches]];
    [self delayUpdateWithTouches:remainingTouches];
}

- (void)reset
{
    [self.delayTimer invalidate];
    self.delayTimer = nil;
    self.touchPath = nil;
}

- (void)delayUpdateWithTouches:(NSSet *)touches
{
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        NSLog(@"delay update with %u touches", (uint)[touches count]);
        [self.delayTimer invalidate];
        self.delayTimer = [NSTimer scheduledTimerWithTimeInterval:kDelayTimerDuration
                                                           target:self
                                                         selector:@selector(handleTimer:)
                                                         userInfo:@{ @"touches" : touches }
                                                          repeats:NO];
    }
}

- (void)handleTimer:(NSTimer *)timer
{
    NSSet *touches = timer.userInfo[@"touches"];
    [self updateStateWithTouches:touches];
}

- (void)updateStateWithTouches:(NSSet *)touches
{
    BOOL isMultiTouch = [touches count] > 1;

    switch (self.state) {
        case UIGestureRecognizerStatePossible:
            if (isMultiTouch) {
                NSLog(@"began with %u touches", (uint)[touches count]);
                self.touchPath = [UIBezierPath bezierPath];
                [self updatePathWithTouches:touches];
                self.state = UIGestureRecognizerStateBegan;
            }
            break;

        case UIGestureRecognizerStateChanged:
            if (isMultiTouch) {
                NSLog(@"updated with %u touches", (uint)[touches count]);
                [self updatePathWithTouches:touches];
                self.state = UIGestureRecognizerStateChanged;
            } else {
                NSLog(@"ended with %u touches", (uint)[touches count]);
                self.state = UIGestureRecognizerStateEnded;
            }
            break;

        default:
            break;
    }
}

#pragma mark - Private

- (void)updatePathWithTouches:(NSSet *)touches
{
    [self.touchPath removeAllPoints];
    
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInView:self.view];
        if ([self.touchPath isEmpty]) {
            [self.touchPath moveToPoint:p];
        } else {
            [self.touchPath addLineToPoint:p];
        }
    }
    [self.touchPath closePath];
}

- (NSSet *)setByRemovingSet:(NSSet *)set fromSet:(NSSet *)fromSet
{
    NSMutableSet *removedSet = [fromSet mutableCopy];
    [removedSet minusSet:set];
    return removedSet;
}

@end
