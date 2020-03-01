//
//  ParticleSystem.swift
//  Stress
//
//  Created by Shawn Koh on 1/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

class ParticleSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene,
                   requiredComponents: [ParticleComponent.self,
                                        IsEmittingParticlesComponent.self,
                                        TransformComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach {
            guard
                let particleComponent = $0.component(ofType: ParticleComponent.self),
                let isEmittingParticlesComponent = $0.component(ofType: IsEmittingParticlesComponent.self),
                let position = $0.component(ofType: TransformComponent.self)?.position
            else {
                fatalError("Unable to access components")
            }
            particleComponent.emitterLayer.birthRate = 1
            particleComponent.emitterLayer.emitterPosition = position
            isEmittingParticlesComponent.duration += deltaTime

            if isEmittingParticlesComponent.duration > particleComponent.duration {
                particleComponent.emitterLayer.birthRate = 0
                $0.removeComponent(ofType: IsEmittingParticlesComponent.self)
            }
        }
    }
}
