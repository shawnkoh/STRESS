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

//        BKPhysicsEdge(from: <#T##CGPoint#>, to: <#T##CGPoint#>)
//        let leftEdge = BKPhysicsEdge(center: .zero, radius: 64, mass: 1.125, velocity: .zero)
//        let leftEdgePhysicsComponent = PhysicsComponent(physicsBody: leftEdge)
//        addComponent(leftEdgePhysicsComponent)
//
//        let rightEdge = BKPhysicsCircle(center: .zero, radius: 64, mass: 1.125, velocity: .zero)
//        let rightEdgePhysicsComponent = PhysicsComponent(physicsBody: rightEdge)
//        addComponent(rightEdgePhysicsComponent)
    }
}
