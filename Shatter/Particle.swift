//
//  Particle.swift
//  ParticleSystem
//
// Based on Processing examples from
// The Nature of Code
// By Daniel Shiffman
// http://natureofcode.com


import Foundation
import Tin


class Particle: Equatable {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var lifespan: Double
    var mass: Double
    
    
    init(location: TVector2) {
        position = location
        velocity = TVector2(x: random(min: -1.0, max: 1.0), y: random(min: 2.0, max: 0.0))
        acceleration = TVector2(x: 0.0, y: -0.05)
        lifespan = 255.0
        mass = 1.0
    }
    
    func run() {
        update()
        display()
    }
    
    func update() {
        velocity = velocity + acceleration
        position = position + velocity
        acceleration = acceleration * 0.0
        lifespan -= 2.0
    }
    
    func applyForce(force: TVector2) {
        acceleration = acceleration + force / mass
    }
    
    func display() {
        let a = lifespan / 255.0
        strokeDisable()
        lineWidth(2.0)
        fillColor(red: random(min: 0.0, max: 1.0), green: random(min: 0.0, max: 1.0), blue: random(min: 0.0, max: 1.0), alpha: a)
        ellipse(centerX: position.x, centerY: position.y, width: 6.0, height: 6.0)
    }
    
    func isDead() -> Bool {
        if lifespan < 0.0 {
            return true
        }
        else {
            return false
        }
    }
    
    static func == (lhs: Particle, rhs: Particle) -> Bool {
        return lhs === rhs
    }
}
