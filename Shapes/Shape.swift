//
//  Shape.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 7/7/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class Shape: SKSpriteNode {
    
    // size for inner node
    let innerNodeSize: CGSize = CGSize(width: 50.0, height: 50.0)
    
    // external variable for reference
    var points: (a: CGPoint, b: CGPoint) = (CGPointZero, CGPointZero)
    
    // max and minimum for Shape
    var nodeSizeMin: CGFloat = 20.0
    var nodeSizeMax: CGFloat = 500.0
    
    // color
    let outerNodeColor: UIColor = UIColor.randomNiceColor()
    let innerNodeColor: UIColor = UIColor.blackColor()
    
    // nodes
    var outerNode: SKShapeNode!
    var outerEdgeLoop: SKShapeNode!
    var innerNode: SKShapeNode!
    
    init(points: (CGPoint, CGPoint)) {
        
        super.init(texture: nil, color: nil, size: size)
        
        // Init Nodes
        makeNodes(points)
    }
    
    func setupNode(size: CGSize, volume: Bool, color: UIColor?, bitMask: UInt32) -> SKShapeNode {
        
        /**
            Make Node
        */
        var node = SKShapeNode(rectOfSize: size)
        
        // set physicsbody
        setPhysicsBodyForNode(node, volume: volume, bitMask: bitMask)

        // set color
        setColorForNode(node, color: (color ? color! : UIColor.randomNiceColor()))
        
        return node
    }
    
    func setColorForNode(node: SKShapeNode, color: UIColor) {
        
        node.fillColor = color
        node.strokeColor = UIColor.clearColor()
    }
    
    func setPhysicsBodyForNode(node: SKShapeNode, volume: Bool, bitMask: UInt32?) {
        
        if volume {
  
            // With Volume
            node.physicsBody = SKPhysicsBody(polygonFromPath: node.path)
            node.physicsBody.affectedByGravity = false // until released
            
        } else {
            
            // Without Volume
            node.physicsBody = SKPhysicsBody(edgeLoopFromPath: node.path)
            node.physicsBody.affectedByGravity = false
        }
        
        // set bitmask for physicsbody
        if bitMask {
    
            node.physicsBody.collisionBitMask = bitMask!
            node.physicsBody.categoryBitMask = bitMask!
            node.physicsBody.contactTestBitMask = bitMask!
        }
    }
    
    func setPhysics(state: Bool) {
        
        outerNode.physicsBody.affectedByGravity = state
        outerEdgeLoop.physicsBody.affectedByGravity = state
        innerNode.physicsBody.affectedByGravity = state
    }
    
    func updatePoints(newPoints: (a: CGPoint, b: CGPoint)) {
     
        points = newPoints
    }
    
    func makeNodes(points: (a: CGPoint, b: CGPoint)) -> Shape {
        
        if self.children.count > 0 {

            // remove innerNode from outerEdgeLoop
            outerEdgeLoop.removeAllChildren()
            
            // remove previous children in Node
            self.removeAllChildren()
        }
        
        // set points
        updatePoints(points)
        
        // get point info
        let info = points.a.getInfoToPoint(points.b)
        
        // find size from point distance
        let h = max(nodeSizeMin, nodeSizeMax-info.pointDistance)
        let nodeSize = CGSize(width: h, height: info.pointDistance)
        
        /**
            Make Nodes to match Size, Position and Angle
        */
        outerNode = setupNode(nodeSize, volume: true, color: outerNodeColor, bitMask: 1)
        outerEdgeLoop = setupNode(nodeSize, volume: false, color: UIColor.clearColor(), bitMask: 2)
        
        // add update nodes
        self.addChild(outerNode)
        self.addChild(outerEdgeLoop)
        
        /**
            Make Inner Node
        */
        if !innerNode {
            innerNode = setupNode(innerNodeSize, volume: true, color: innerNodeColor, bitMask: 2)
        }
        
        // add inner node
//        outerEdgeLoop.addChild(innerNode)
        
        /**
            Transform
        */
        self.size = nodeSize
        
        // position (centered from points)
        self.position = info.pointCenter
        
        // angle (note: in radians)
        self.zRotation = info.pointAngle
        
        return self
    }
}

