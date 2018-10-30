//
//  ParticleSystem.swift
//  NOC_4_03_ParticleSystemClass
//
// Based on Processing examples from
// The Nature of Code
// By Daniel Shiffman
// http://natureofcode.com

import Foundation
import Tin


class ParticleSystem {
    var particles: [Particle]
    var origin: TVector2
    
    init(position: TVector2) {
        origin = position
        origin = TVector2(x: position.x, y: position.y)
        particles = []
    }
    
    func addParticle(x: Double, y: Double) {
        let point = TVector2(x: x, y: y)
        let p = Particle(location: point)
        particles.insert(p, at: 0)
    }
    
    func applyForce(force: TVector2) {
        for p in particles {
            p.applyForce(force: force)
        }
    }
    
    func run() {
        for p in particles {
            p.run()
            if p.isDead() {
                if let i = particles.index(of: p) {
                    particles.remove(at: i)
                }
            }
        }
    }
}
