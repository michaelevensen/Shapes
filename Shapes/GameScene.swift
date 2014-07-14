//
//  GameScene.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 6/14/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var touchesDict = Dictionary<UITouch, Shape>()
    
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
        
        let pairedTouches = event.allTouches().allObjects.pair() // pair all
        
//        let pairedTouches = touches.allObjects.pair()
        
        // make shapes for each pair of touches
        if !pairedTouches.isEmpty {
            
            for touch in pairedTouches {
                
                // setup points for shape
                let pointa = touch[0].locationInNode(self)
                let pointb = touch[1].locationInNode(self)
                
                // make shape
                let shape = Shape(points: (pointa, pointb))
                
                // keep track of current
//                currentNodesArray += shape
                
                touchesDict[touch[0]] = shape
                touchesDict[touch[1]] = shape
                
                // add to scene
                self.addChild(shape)
            }
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        
        let pairedTouches = touches.allObjects.pair()
        
        // make shapes for each pair of touches
        if !pairedTouches.isEmpty {

            for (index, touch) in enumerate(pairedTouches) {
                
//                touchesDict.indexForKey(<#key: KeyType#>)
                
                var index = touchesDict.indexForKey(touch[0] as UITouch)
                
                
//                println( touchesDict[index!].1 )
                
                
//                let shape = currentNodesArray[index]
                
                // setup points for shape
//                let pointa = touch[0].locationInNode(self)
//                let pointb = touch[1].locationInNode(self)
//                
//                // new size and location
//                let points = (pointa, pointb)
//                
//                // update current shape
//                shape.updateNodes(a: pointa, b: pointb)
            }
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        
    
//        for touches: AnyObject in touches.allObjects {
//            
//            if shape.points.a && shape.points.b ==
//            
//        }
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