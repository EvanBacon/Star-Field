//
//  ParallaxNode.swift
//  Starfield
//
//  Created by Evan Bacon on 10/19/15.
//

import UIKit
import SpriteKit

class ParallaxNode: SKSpriteNode {
    // scene bounderies
    let lower_x_boud : CGFloat = 0.0
    let lower_y_boud : CGFloat = 0.0
    var higher_x_bound : CGFloat = 0.0
    var higher_y_bound : CGFloat = 0.0
    
    //star layers one properties
    var star_layer : [[SKSpriteNode]] = []
    var star_layer_speed : [CGFloat]  = []
    var star_layer_color : [SKColor] = []
    var star_layer_count : [Int] = []
    
    // scroll direction
    var direction: CGPoint = CGPointMake(-1, 0)

    
    
    //deltaTime
    var lastUpdate : NSTimeInterval = 0
    // 1/60 ~> 0.0166
    var deltaTime : CGFloat = 0.01666
    
    // used to demo 8 way scrolling
    var currentDir = 1
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
    }
    
    
    convenience init(size: CGSize) {

        self.init(texture: nil, color: SKColor.clearColor(), size: size)
        
        
//        self.position = self.startPosition
//        
//        self.zPosition = GameLayer.Game
//        
//        
//        
        self.setupParallax()
//        self.setupPlayerPhysics()
//        self.setupEngineParticles()
    }
    
    
    func updateDirection(direction: CGPoint) {
     self.direction = direction
    }

    func setupParallax(){
        
        // set the boundries
        higher_x_bound = self.frame.width
        higher_y_bound = self.frame.height
        
        // create the 3 star layers
        star_layer = []
        
        
//        let colors = getColorAccentForColor(randomBrightColor(), count: (random() % 3) + 3)
        
        
        let colors = getColorTriadForColor(randomBrightColor())
        var speed = colors.count * 10
        for color in colors {
            //set layer 0
            star_layer.append([SKSpriteNode()])
            star_layer_count.append(50)
            star_layer_speed.append(CGFloat(speed))
            star_layer_color.append(color)

            speed -= 10
        }
        
        bindLayers()
    }
    
    
    func bindLayers(){
        
        //draw all the stars in all the layers
        for starLayers in 0...star_layer_count.count - 1 {
            
            //draw all the stars in a single layer
            for _ in 1...star_layer_count[starLayers] {
                
                let size = CGFloat((random() % 3) + 2)
                let sprite = SKSpriteNode(color: star_layer_color[starLayers], size: CGSizeMake(size, size))
                
//                let sprite = SKSpriteNode(imageNamed: "star")

                // set the correct color for the star in that layer
//                sprite.colorBlendFactor = 1.0
//                sprite.color = star_layer_color[starLayers]
                
                
                
                // get a random position for the star
                let x_pos = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * higher_x_bound
                let y_pos = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * higher_y_bound
                sprite.position = CGPointMake(x_pos, y_pos)
              

                switch random() % 3 {

                case 0:
                    let fadeTime = Double(drand48() % 3.0) + 3.0
                    sprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                        SKAction.colorizeWithColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0), colorBlendFactor: 1.0, duration: fadeTime),
                        SKAction.colorizeWithColor(sprite.color, colorBlendFactor: 1.0, duration: fadeTime)
                        ])))

                    break
                case 1:
                    let fadeTime = Double(drand48() % 3.0) + 3.0
                    sprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                        SKAction.scaleBy(2, duration: fadeTime),
                        SKAction.scaleBy(0.5, duration: fadeTime)
                        ])))
                    
                    break
                case 2:
                    let fadeTime = Double(drand48() % 3.0) + 3.0
                    sprite.runAction(SKAction.repeatActionForever(
                        SKAction.rotateByAngle(3, duration: fadeTime)
                        ))
                    
                    break
                default:
                    
                    break
                }
              
                
                
                
                star_layer[starLayers].append(sprite)
                self.addChild(sprite)
                
            }
        }
        
    }
    
    func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        deltaTime = CGFloat( currentTime - lastUpdate)
        lastUpdate = currentTime
        
        if deltaTime > 1.0 {
            deltaTime = 0.0166
        }
        
        updateParallax()
    }
    
    func updateParallax(){
        //move starfield
        for index in 0...star_layer.count - 1 {
            MoveSingleLayer(star_layer[index], speed: star_layer_speed[index])
        }
        
    }
    
    
    func MoveSingleLayer(star_layer:[SKSpriteNode],speed:CGFloat) {
        
        var sprite:SKSpriteNode
        var new_x:CGFloat = 0.0
        var new_y:CGFloat = 0.0
        
        for index in 0...star_layer.count-1 {
            
            sprite = star_layer[index]
            new_x = sprite.position.x + direction.x * speed * deltaTime
            new_y = sprite.position.y + direction.y * speed * deltaTime
            
            sprite.position = boundCheck( CGPointMake(new_x, new_y) )
        }
    }

    
    func boundCheck(pos: CGPoint) -> CGPoint {
        var x = pos.x
        var y = pos.y
        
        if x < 0 {
            x += higher_x_bound
        }
        if y < 0 {
            y += higher_y_bound
        }
        if x > higher_x_bound {
            x -= higher_x_bound
        }
        if y > higher_y_bound {
            y -= higher_y_bound
        }
        
        return CGPointMake(x, y)
    }
    
    
}
