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
        cell.birthRate = 900
        cell.lifetime = 0.3
        cell.lifetimeRange = 0.2
        cell.velocity = 40
        cell.velocityRange = 90
        cell.yAcceleration = -650
        cell.emissionRange = 3
        cell.emissionLongitude = -1.4

        cell.scale = 0.2
        cell.scaleRange = 0.6
        cell.color = UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 0.3).cgColor
        cell.contents = UIImage(named: "particle")!.cgImage
        cell.redRange = 1

        cell.spin = 30
        cell.spinRange = 3
        emitterLayer.emitterCells = [cell]

        let particleComponent = ParticleComponent(emitterLayer: emitterLayer, duration: 0.01)
        addComponent(particleComponent)
    }
}
