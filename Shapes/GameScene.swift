//
//  GameScene.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 6/14/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var nodes = [Shape]() // node array
    var nodeSizeMin: CGFloat = 20.0
    var nodeSizeMax: CGFloat = 500.0
    
    override func didMoveToView(view: SKView) {
        
        setupScene()
    }
    
    func setupScene() {
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.view.frame)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
       
        // all touches
        var touchesArray = event.allTouches().allObjects
       
        /**
            Pair touches in two
        */
        var touchPairsArray = pairTouches(touchesArray)
        
        // make nodes for pairs (if exist)
        if touchPairsArray.count > 0 {
            
            for (index, touchPair: [UITouch]) in touchPairsArray {
                
                // get point info between points
                var firstPoint = touchPair[0].locationInNode(self)
                var secondPoint = touchPair[1].locationInNode(self)
                
                var info = firstPoint.getInfoToPoint(secondPoint)
                
                /**
                    Make Node
                */
                var h = max(nodeSizeMin, nodeSizeMax-info.pointDistance)
                var size = CGSize(width: h, height: info.pointDistance)
                
                var node = Shape(size: size, position: info.mid, angle: info.pointAngle.toRadians())
                
                // add to nodes array
                nodes += node
                
                self.addChild(node)
            }
        }
    }

    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        
        // all touches
        var touchesArray = event.allTouches().allObjects
        
        /**
            Pair touches in two
        */
        var touchPairsArray = pairTouches(touchesArray)
        
        // make nodes for pairs (if exist)
        if touchPairsArray.count > 0 {
            
            for (index, touchPair: [UITouch]) in touchPairsArray {
              
                // find node
                var node = nodes[index]
                
                // get point info between points
                var firstPoint = touchPair[0].locationInNode(self)
                var secondPoint = touchPair[1].locationInNode(self)
                
                var info = firstPoint.getInfoToPoint(secondPoint)
                
                /**
                    Make nodes with new coordinates
                */
                var h = max(nodeSizeMin, nodeSizeMax-info.pointDistance)
                var size = CGSize(width: info.pointDistance, height: h)
                
                node.makeNodes(size, position: info.mid, angle: info.pointAngle.toRadians())
            }
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        
//        if !nodes.isEmpty {
//            
//            for shapeNode in nodes {
//                
//                if shapeNode.outerNode.physicsBody.affectedByGravity==false {
//                 
//                    // active physics
//                    shapeNode.setPhysics(true)
//                }
//            }
//        }
    }
    
//    func pairTouches(touchesArray: NSArray) -> Dictionary<Int, [UITouch]> {
//        
//        // dictionary for touches
//        var paired = Dictionary<Int, [UITouch]>()
//        
//        // pairing for two touches at a time
//        if touchesArray.count % 2 == 0 {
//            
//            var dictIndex = 0 // index
//            
//            for index in 0..<touchesArray.count {
//                
//                // for every second index
//                if (index+1) % 2 == 0 {
//                    
//                    // add pair
//                    paired[dictIndex] = [touchesArray[index] as UITouch, touchesArray[index-index] as UITouch]
//
//                    // increase dictIndex
//                    dictIndex++
//                }
//            }
//        }
//        else {
//            
//            // uneven amount of touch pairs
//        }
//        
//        return paired
//    }
    
    override func didSimulatePhysics() {

        /**
            Copy Physics for EdgeLoop Nodes
            - This can't be the best way of doing this?
        */
        if !nodes.isEmpty {
        
            for node in nodes {
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