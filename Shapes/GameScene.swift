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
        if touchesArray.count % 2 == 0 {
            
            for index in 0..<touchesArray.count {
                
                /**
                    Make Nodes 
                    - For pairs of points
                */
                if (index + 1) % 2 == 0 {
                    
                    // get point info
                    var touchPoints: (a: CGPoint, b: CGPoint) = (touchesArray[index-1].locationInNode(self), touchesArray[index].locationInNode(self))
                    var info = touchPoints.a.getInfoToPoint(touchPoints.b)
                    
                    // find size based on points
                    var size = CGSize(width: info.pointDistance, height: max(nodeSizeMin, nodeSizeMax-info.pointDistance))
               
                    // make
                    var node = Shape(size: size, position: info.mid, angle: info.pointAngle.toRadians())
                    
                    // add node
                    nodes += node // node array
                    self.addChild(node)
                }
            }
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {

        // all touches
        var touchesArray = event.allTouches().allObjects
        
        /**
            Pair touches in two
        */
        if touchesArray.count % 2 == 0 {
           
            // node count
            var nodeCount = 0
            
            for index in 0..<touchesArray.count {
                
                /**
                    Make Nodes
                    - For pairs of points
                */
                if (index + 1) % 2 == 0 {
                    
                    // get point info
                    var touchPoints: (a: CGPoint, b: CGPoint) = (touchesArray[index-1].locationInNode(self), touchesArray[index].locationInNode(self))
                    var info = touchPoints.a.getInfoToPoint(touchPoints.b)
                    
                    // find size based on points
                    var size = CGSize(width: info.pointDistance, height: max(nodeSizeMin, nodeSizeMax-info.pointDistance))
                    
                    for node in nodes {
                        
                        node.makeNodes(size, position: info.mid, angle: info.pointAngle.toRadians())
                    }
                }
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
//    override func didSimulatePhysics() {
//
//        /**
//            Copy Physics for EdgeLoop Nodes
//            - This can't be the best way of doing this?
//        */
//        if !nodes.isEmpty {
//        
//            for node in nodes {
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