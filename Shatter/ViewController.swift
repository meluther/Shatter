//
//  ViewController.swift
//  ParticleSystem
//
// Based on Processing examples from
// The Nature of Code
// By Daniel Shiffman
// http://natureofcode.com

import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!

    override func viewWillAppear() {
        view.window?.title = "Shatter"
        makeView(width: 1200.0, height: 600.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    // To reset, press r
    override func keyUp(with event: NSEvent) {
        if let keys = event.charactersIgnoringModifiers {
            if keys == "r" {
                scene.reset()
            }
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        scene.createSystem(x: tin.mouseX, y: tin.mouseY)
        print("mouseUp at \(tin.mouseX),\(tin.mouseY)")
    }
}

class Scene: TScene {
    
    var systems: [ParticleSystem] = []
    var gravity = TVector2(x: 0.0, y: -0.1)
    var shape = Shape(x: 100.0, y: 100.0, w: 100.0)
    var shapes : [Shape] = []
    var count = 0
    var shape2 = Circle(x: 400, y: 500, w: 300)
    
    override func setup() {
        for _ in 1...6 {
            let s = Shape(x: random(min: 0, max: tin.width - 300.0), y: random(min: 0, max: tin.height - 300.0), w: random(min: 50, max: 150))
            shapes.append(s)
        }
    }
    
    override func update() {
        background(gray: 0.0)
        
        for shape in shapes {
            shape.render()
        }
        
        for ps in systems {
            ps.applyForce(force: gravity)
            ps.run()
        }
    }
    
    func createSystem(x: Double, y: Double) {
        for shape in shapes {
            if shape.isInside(x: x, y: y) {
                let ps = ParticleSystem(position: TVector2(x: tin.mouseX, y: tin.mouseY))
                shape.generate(ps: ps)
                systems.append(ps)
                shape.active = false
                count = count + 1
            }
        }
    }

    func remove() {
        if systems.count > 0 {
            systems.remove(at: 0)
        }
    }
    
    func reset() {
        for _ in 1...count {
            let s = Shape(x: random(max: tin.width), y: random(max: tin.height), w: random(min: 50, max: 200))
            shapes.append(s)
        }
        count = 0
    }
}


