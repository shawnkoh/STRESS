//
//  ParticleComponent.swift
//  Stress
//
//  Created by Shawn Koh on 1/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class ParticleComponent: GKComponent {
    let emitterLayer: CAEmitterLayer
    let duration: TimeInterval

    init(emitterLayer: CAEmitterLayer, duration: TimeInterval) {
        self.emitterLayer = emitterLayer
        self.duration = duration
    }
}
