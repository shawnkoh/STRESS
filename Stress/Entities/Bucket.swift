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
        view.bounds.size = CGSize(width: 64, height: 64)
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        let physicsBody = BKPhysicsCircle(center: .zero, radius: 64, mass: 1.125, velocity: .zero)
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody)
        addComponent(physicsComponent)
    }
}
