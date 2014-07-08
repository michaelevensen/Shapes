//
//  GameScene.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 6/14/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var currentNodesArray = [Shape]() // holds current nodes
    
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
            
//            var nodeCount = 0
            
            for index in 0..<touchesArray.count {
                
                // for every second
                if (index + 1) % 2 == 0 {
                    
                    // check if node is already in array
                    if currentNodesArray.count > index - 1 {
                        
                        println(index)
                        
                        // make node
                        var node = makeShapeFromPoints(touchesArray[index-1].locationInNode(self), b: touchesArray[index].locationInNode(self))

                        // keep track of current nodes
                        currentNodesArray += node
                        
                        // add
                        self.addChild(node)
                    }
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
                
//                 println("moved: \((index + 1) % 2)")
                
                // for every second
//                if (index + 1) % 2 == 0 {
//
//                    // remove previous node
//                    currentNodesArray[nodeCount].removeFromParent()
//                    
//                    // make new node
//                    var node = makeShapeFromPoints(touchesArray[index-1].locationInNode(self), b: touchesArray[index].locationInNode(self))
//                    
//                    // update current nodes
//                    currentNodesArray[nodeCount] = node
//                    
//                    // add
//                    self.addChild(node)
//                    
//                    nodeCount++
//                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {

        currentNodesArray = []
        
        
//        if !nodesArray.isEmpty {
//            
//            for node in nodesArray {
//                
//                if node.outerNode.physicsBody.affectedByGravity==false {
//                 
//                    // active physics
//                    node.setPhysics(true)
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
    
    func makeShapeFromPoints(a: CGPoint, b: CGPoint) -> Shape {
        
        // get point info
        var info = a.getInfoToPoint(b)
        
        // find size based on points
        var size = CGSize(width: info.pointDistance, height: max(nodeSizeMin, nodeSizeMax-info.pointDistance))
        
        return Shape(size: size, position: info.mid, angle: info.pointAngle.toRadians())
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