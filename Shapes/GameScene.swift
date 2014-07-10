//
//  GameScene.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 6/14/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var labels = Dictionary<UITouch, SKLabelNode>()
    
    var totalNodesArray = [Shape]() // all nodes on scene (excluding current)
    var currentNodesArray = [Shape]() // currently being manipulated
    
    override func didMoveToView(view: SKView) {
        
        setupScene()
    }
    
    func setupScene() {
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.view.frame)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
       
        var points = [CGPoint]()
        
        // only add per new event
        for touch: AnyObject in touches.allObjects {
            
            // add label
            var labelStr = String("time: \(touch.timestamp) - previous: \(touch.previousLocationInNode(self)) - current: \(touch.locationInNode(self))")
            
            var label = SKLabelNode(text: labelStr)
            label.position = touch.locationInNode(self)
            label.position.y += 50.0
            
            label.fontSize = 16.0
            label.fontColor = UIColor.blackColor()
            
            // associate label with uitouch
            labels[touch as UITouch] = label
            
            self.addChild(label)
        }
        
//        for touch: AnyObject in event.allTouches().allObjects {
//            
//            let location = touch.locationInNode(self)
//            
////            println(touchId)
//            
//            println("touch \(touchId): \(touch.timestamp)")
//            
//            touchId++
//            
//            // save location
//            points += location
//        }
        
        // make shapes from points
//        let shapes = ShapesFromPoints(pointsArray: points)
        
        
//        // check for pairs
//        if shapes {
//        
//            for node in shapes {
//                
//                // add current nodes to array
//                currentNodesArray += node
//                
//                // add to scene
//                self.addChild(node)
//            }
//        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {

       for touch: AnyObject in touches.allObjects {
    
            var index = labels.indexForKey(touch as UITouch)
        
            // remove label
            var label = labels[index!].1
            
            // position label
            label.position = touch.locationInNode(self)
            label.position.y += 50.0
            
            // set string
            var labelStr = String("time: \(touch.timestamp) - previous: \(touch.previousLocationInNode(self)) - current: \(touch.locationInNode(self))")
            label.text = labelStr
        
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
    
        for touch: AnyObject in touches.allObjects {

            var label = labels.removeValueForKey(touch as UITouch)
            
            // remove node
            self.removeChildrenInArray([label!])
        }
    }
    
        
   /**
        for touch: AnyObject in touches.allObjects {
        
            let location = touch.locationInNode(self)
        
            for node in currentNodesArray {

                if (location.x, location.y) == node.nodePoints.a || node.nodePoints.b {
                    println("touch is part of: \(node)")
                }
            }
        }
        
        for index in 0..<currentNodesArray.count {
            
            // add to total
            totalNodesArray += currentNodesArray[index]
            
            // remove from current
            currentNodesArray.removeAtIndex(index)
        }
*/

//    override func didSimulatePhysics() {
//
//        /**
//            Copy Physics for EdgeLoop Nodes
//            - This can't be the best way of doing this?
//        */
//        if !totalNodesArray.isEmpty {
//        
//            for node in totalNodesArray {
//                copyPhysics(node)
//            }
//        }
//    }

    func copyPhysics(node: Shape) {
        
        node.outerEdgeLoop.position = node.outerNode.position
        node.outerEdgeLoop.zRotation = node.outerNode.zRotation
        node.outerEdgeLoop.zPosition = node.outerNode.zPosition
    }
    
    override func update(currentTime: NSTimeInterval)  {
        //
    }
}