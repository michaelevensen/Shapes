//
//  PathGestureRecognizer.h
//  Shapes
//
//  Created by Rnald on 03/05/2014.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathGestureRecognizer : UIGestureRecognizer
@property (nonatomic, readonly) UIBezierPath *touchPath;
@end
