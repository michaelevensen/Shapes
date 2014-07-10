//
//  GameScene.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 6/14/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
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
       
        var shapes = ShapesFromTouches(touches: touches)

        // check for pairs
        if shapes {
        
            for node in shapes {
                
                // add current nodes to array
                currentNodesArray += node
                
                // add to scene
                self.addChild(node)
            }
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {

       
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
 
        
        for touch: AnyObject in touches.allObjects {
        
            let location = touch.locationInNode(self)
        
            // match position of current touch point to location of shape
            // this is impossible given that the Shape only takes one position
            
        }
        
        for index in 0..<currentNodesArray.count {
            
            // add to total
            totalNodesArray += currentNodesArray[index]
            
            // remove from current
            currentNodesArray.removeAtIndex(index)
        }
    }
    
    override func didSimulatePhysics() {

        /**
            Copy Physics for EdgeLoop Nodes
            - This can't be the best way of doing this?
        */
        if !totalNodesArray.isEmpty {
        
            for node in totalNodesArray {
                copyPhysics(node)
            }
        }
    }
    
    func copyPhysics(node: Shape) {
        
        node.outerEdgeLoop.position = node.outerNode.position
        node.outerEdgeLoop.zRotation = node.outerNode.zRotation
        node.outerEdgeLoop.zPosition = node.outerNode.zPosition
    }
    
    override func update(currentTime: NSTimeInterval)  {
        //
    }
}