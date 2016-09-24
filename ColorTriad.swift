//
//  ColorTriad.swift
//  Starfield
//
//  Created by Evan Bacon on 10/19/15.
//

import Foundation
import UIKit

func getColorTriadForColor(color:UIColor) -> [UIColor] {
    
    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    var triad1 = h + (1.0/3.0)
    if triad1 >= 1.0 {
        triad1 = triad1 - 1
    }
    let triA = UIColor(
        hue: triad1,
        saturation: s,
        brightness: b,
        alpha: a)
    
    var triad2 = h + (2.0/3.0)
    if triad2 >= 1.0 {
        triad2 = triad2 - 1
    }
    
    let triB = UIColor(
        hue: triad2,
        saturation: s,
        brightness: b,
        alpha: a)


    return [color,triA,triB]
}


func getColorAccentForColor(color:UIColor, count: Int) -> [UIColor] {
    let interval = CGFloat(6.0)
    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)

    
    var colors:[UIColor] = []
    for i in 0...count - 1  {
        
        var triad1 = h + (CGFloat(i)/interval)
        if triad1 >= 1.0 {
            triad1 = triad1 - 1
        }
        let triA = UIColor(
            hue: triad1,
            saturation: s,
            brightness: b,
            alpha: a)
        
        colors.append(triA)
    }
   
    return colors
}


func randomBrightColor() -> UIColor {
    var randomHue:CGFloat = randomCGFloat()
    print(randomHue)
//    var randomGreen:CGFloat = CGFloat(drand48())
    
//    var randomBlue:CGFloat = CGFloat(drand48())
    
    return UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    
}
func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
}
