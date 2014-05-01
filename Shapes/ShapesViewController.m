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
    NSArray *touchesArray = [touches allObjects];
    
    // New Shape View
    [self setCurrentShape:[[ShapesView alloc] init]];
    
    /*
     * Multiple Touches Began
     */
    if ([[event touchesForView:self.view] count]>1) {
        
        // Make Path from Touch Points
        [self.currentShape makePathFromPoints:touchesArray];
    }
    
    // Add Shape to View
    [self.view addSubview:self.currentShape];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *touchesArray = [touches allObjects];
    
    // Set new Points for Path
    if ([[event touchesForView:self.view] count]>1) {
        
        // Make Path from Touch Points
        [self.currentShape makePathFromPoints:touchesArray];
    }
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
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
//}

@end
