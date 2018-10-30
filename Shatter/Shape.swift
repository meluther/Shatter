//
//  Shape.swift
//  Shatter
//
//  Created by Molly Luther on 10/18/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation 
import Tin

class Shape {
    
    var position: TVector2
    var width: Double
    var r: Double
    var g: Double
    var b: Double
    var active: Bool

    init(x: Double, y: Double, w: Double) {
        position = TVector2(x: x, y: y)
        width = w
        r = random(min: 0.0, max: 1.0)
        g = random(min: 0.0, max: 1.0)
        b = random(min: 0.0, max: 1.0)
        active = true
    }
    
    func isInside(x: Double, y: Double) -> Bool {
        if x >= position.x && x <= position.x + width && y >= position.y && y <= position.y + width {
            return active
        }
        else {
            return false
        }
    }

    func render() {
        if active == true {
            fillColor(red: r, green: g, blue: b, alpha: 1.0)
            rect(x: position.x, y: position.y, width: width, height: width)
        }
    }

    func generate(ps: ParticleSystem) {
        let particleRadius = 6.0
        var y = position.y + particleRadius

        while y < position.y + width - particleRadius {
            var x = position.x + particleRadius
            while x < position.x + width - particleRadius {
                ps.addParticle(x: x, y: y)
                x = x + particleRadius * 2.0
            }
            y = y + particleRadius * 2.0
        }
    }
}

