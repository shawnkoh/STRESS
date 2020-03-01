//
//  Bucket.swift
//  Stress
//
//  Created by Shawn Koh on 28/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Bucket: GKEntity {
    override init() {
        super.init()

        let transformComponent = TransformComponent(position: .zero)
        addComponent(transformComponent)

        let view = UIImageView(frame: .zero)
        view.image = Settings.Bucket.image
        view.bounds.size = CGSize(width: 632 / 5, height: 275 / 5)
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        let edge = BKPhysicsEdge(from: .zero, to: .zero)
        let physicsComponent = PhysicsComponent(physicsBody: edge)
        addComponent(physicsComponent)

        addComponent(BucketComponent())

        let emitterLayer = CAEmitterLayer()
        emitterLayer.renderMode = .additive
        let cell = CAEmitterCell()
        cell.birthRate = 800
        cell.lifetime = 1.3
        cell.lifetimeRange = 0.3
        cell.velocity = 150
        cell.velocityRange = 50
        cell.emissionRange = .pi * 2
        cell.scale = 0.7
        cell.color = UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 0.3).cgColor
        cell.contents = UIImage(named: "particle")!.cgImage
        emitterLayer.emitterCells = [cell]

        let particleComponent = ParticleComponent(emitterLayer: emitterLayer, duration: 0.3)
        addComponent(particleComponent)
    }
}
