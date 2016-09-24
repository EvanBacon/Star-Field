//
//  ParallaxNode.swift
//  Starfield
//
//  Created by Evan Bacon on 10/19/15.
//

import SpriteKit

class GameScene: SKScene {
    // used to demo 8 way scrolling
    var currentDir = 1
    
    var parallaxNode:ParallaxNode!
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // set the screen color
        self.backgroundColor = SKColor.blackColor()
        parallaxNode = ParallaxNode(size: self.size)
        self.addChild(parallaxNode)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //change direction when screen is tapped
        for touch: AnyObject in touches {
            
            switch currentDir {
            case 0:
                parallaxNode.updateDirection(CGPointMake(0, -1))
            case 1:
                parallaxNode.updateDirection(CGPointMake(-1, -1))
            case 2:
                parallaxNode.updateDirection(CGPointMake(-1, 0))
            case 3:
                parallaxNode.updateDirection(CGPointMake(-1, 1))
            case 4:
                parallaxNode.updateDirection(CGPointMake(0, 1))
            case 5:
                parallaxNode.updateDirection(CGPointMake(1, 1))
            case 6:
                parallaxNode.updateDirection(CGPointMake(1, 0))
            case 7:
                parallaxNode.updateDirection(CGPointMake(1, -1))
            default:
                parallaxNode.updateDirection(CGPointMake(0, 0))
                currentDir = 0
            }
            currentDir = (currentDir + 1) % 8
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        parallaxNode.update(currentTime)
    }
}
