//
//  Shape.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 7/7/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//

import SpriteKit

class Shape: SKSpriteNode {
    
    let innerNodeSize: CGSize = CGSize(width: 50.0, height: 50.0)
    
    // position
    var shapePosition: (CGPoint, CGPoint) = (CGPointZero, CGPointZero) // touple for two points
    
    // color
    let outerNodeColor: UIColor = UIColor.randomNiceColor()
    let innerNodeColor: UIColor = UIColor.blackColor()
    
    // nodes
    var outerNode: SKShapeNode!
    var outerEdgeLoop: SKShapeNode!
    var innerNode: SKShapeNode!
    
    init(size: CGSize, points: (a: CGPoint, b: CGPoint), angle: CGFloat) {
        
        super.init(texture: nil, color: nil, size: size)
        
        // Init Nodes
        makeNodes(size, points: (points.a, points.b) , angle: angle)
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
    
    func makeNodes(size: CGSize, points: (a: CGPoint, b: CGPoint), angle: CGFloat) -> Shape {
        
        // save position
        shapePosition = points
        
        if self.children.count > 0 {

            // remove innerNode from outerEdgeLoop
            outerEdgeLoop.removeAllChildren()
            
            // remove previous children in Node
            self.removeAllChildren()
        }
        
        /**
            Make Nodes to match Size, Position and Angle
        */
        outerNode = setupNode(size, volume: true, color: outerNodeColor, bitMask: 1)
        outerEdgeLoop = setupNode(size, volume: false, color: UIColor.clearColor(), bitMask: 2)
        
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
        self.size = size
        
        // position (centered from two points)
        self.position = points.a.midToPoint(points.b)
        
        // angle (note: in radians)
        self.zRotation = angle
        
        return self
    }
}

