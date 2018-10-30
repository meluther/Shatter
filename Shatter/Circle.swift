//
//  Circle.swift
//  Shatter
//
//  Created by Molly Luther on 10/22/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation
import Tin

class Circle {
    
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
            ellipse(centerX: position.x, centerY: position.y, width: width, height: width)
        }
    }
    
    func generate(ps: ParticleSystem) {
        for _ in 1...200 {
            let radius = sqrt(random(min: 0.0, max: 1.0)) * (width / 2.0)
            let angle = random(max: Double.pi * 2.0)
            let x = radius * cos(angle) + position.x
            let y = radius * sin(angle) + position.y
            ps.addParticle(x: x, y: y)
        }
    }
}

