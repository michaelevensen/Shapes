//
//  ShapesViewController.m
//  Shapes
//
//  Created by Michael Evensen on 4/18/14.
//  Copyright (c) 2014 SoundCloud. All rights reserved.
//

#import "ShapesViewController.h"

@interface ShapesViewController ()

@end

@implementation ShapesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Event touches
//    NSArray *touchesArray = [touches allObjects];
    
    // All touches
    NSSet *allTouches = [event allTouches];
    
    /*
     * Make new ShapeView on First Tap
     * - Don't make new Shapes for taps beyond 1
     * - If taps are >1 then just change the path
     */
    if([allTouches count]==1) {
        
        // New Shape View
        [self setCurrentShape:[[ShapesView alloc] init]];
        
        // Add Shape to View
        [self.view addSubview:self.currentShape];
    }
    
//    else {
//        // Make Path from Touch Points
//        [self.currentShape makePathFromPoints:allTouches];
//    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // All touches
    NSSet *allTouches = [event allTouches];
    
    // Event touches
//    NSArray *touchesArray = [touches allObjects];
    
    // Set new Points for Path
    if ([[event touchesForView:self.view] count]>1) {
        
        // Make Path from Touch Points
        [self.currentShape makePathFromPoints:allTouches];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    float ti = 0.5; // The threshold between touch releases
//    NSArray *touchesArray = [touches allObjects];
//    NSTimeInterval t = [touchesArray.lastObject timestamp];
//    
//    // Compare touchesEnded with previous touches (to group multiple touch releases)
//    if((t-self.touchInterval)>ti) {
//        
//        // If more than one touch release
//        if ([touchesArray count]>1) {
//            
//            //
//        }
//        else {
//            
//           //
//        }
//    }
//    
//    // Get timestamp for grouped touchesEnded event
//    self.touchInterval = t;
}

@end
