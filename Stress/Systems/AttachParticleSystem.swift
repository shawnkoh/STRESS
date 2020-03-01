//
//  AttachParticleSystem.swift
//  Stress
//
//  Created by Shawn Koh on 1/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class AttachParticleSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene,
                   requiredComponents: [ParticleComponent.self],
                   excludedComponents: [DidAttachParticleComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach {
            guard let emitterLayer = $0.component(ofType: ParticleComponent.self)?.emitterLayer else {
                fatalError("Unable to access components")
            }
            scene.view?.layer.addSublayer(emitterLayer)
            emitterLayer.birthRate = 0
            $0.addComponent(DidAttachParticleComponent())
        }
    }
}
