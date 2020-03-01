//
//  BucketHitSystem.swift
//  Stress
//
//  Created by Shawn Koh on 28/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

class BucketHitSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, requiredComponents: [BucketComponent.self, DidHitComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        guard !entities.isEmpty else {
            return
        }

        guard
            let cannon = scene.entities.first(where: { $0 is Cannon }) as? Cannon,
            let ammoComponent = cannon.component(ofType: AmmoComponent.self)
        else {
            fatalError("Unable to access Cannon")
        }
        entities.forEach { bucket in
            ammoComponent.ammo += 1
            (scene as? LevelPlayingScene)?.parent.ammoLabel.text = "Shots left: \(ammoComponent.ammo)"
            bucket.removeComponent(ofType: DidHitComponent.self)
            bucket.addComponent(IsEmittingParticlesComponent())
        }
        scene.entities(ofType: Peg.self)
            .filter { $0.component(ofType: DidHitComponent.self) != nil }
            .forEach { $0.addComponent(WillDestroyComponent()) }
    }
}
