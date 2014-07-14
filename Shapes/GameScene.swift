//
//  GameScene.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 6/14/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var shapesDict = Dictionary<UITouch, Shape>()
    
    var currentNodesArray = [Shape]() // currently being manipulated
    var totalNodesArray = [Shape]() // all nodes on scene (excluding current)
    
    override func didMoveToView(view: SKView) {
        
        setupScene()
    }
    
    func setupScene() {
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.view.frame)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let pairedTouches = event.allTouches().allObjects.pairWithTuples() // pair all
        
//        let pairedTouches = touches.allObjects.pair()
        
        // make shapes for each pair of touches
        if !pairedTouches.isEmpty {
            
            for touchPair in pairedTouches {
                
                // compose location
                var location = (touchPair.A.locationInNode(self), touchPair.B.locationInNode(self))
                
                // make shape
                let shape = Shape(points: location)
                
                // associate touches with Shape
                shapesDict[touchPair.A as UITouch] = shape
                shapesDict[touchPair.B as UITouch] = shape
                
                // add to scene
                self.addChild(shape)
            }
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        
        for touch: AnyObject in touches.allObjects {
         
            // find Shape associated with touch
            var shapeIndex = shapesDict.indexForKey(touch as UITouch)
            
            var shapeReference = shapesDict[shapeIndex!]
            
            // find location for new touch
            var location = touch.locationInNode(self)
            
            // find location for old touch
            var locationOld = shapeReference.0.locationInNode(self)
            
            println("A: \(shapeReference.1.points.a) - B: \(shapeReference.1.points.b)")
            println(location)
            
            // update shape
            shapeReference.1.updateNodes((locationOld, locationOld))
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        //
    }
    
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