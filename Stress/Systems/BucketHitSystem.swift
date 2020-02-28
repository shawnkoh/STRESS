//
//  BucketHitSystem.swift
//  Stress
//
//  Created by Shawn Koh on 28/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class BucketHitSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [BucketComponent.self, DidHitComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        guard !entities.isEmpty else {
            return
        }

        guard
            let cannon = scene.entities.first(where: { $0 is Cannon }) as? Cannon,
            let ammoComponent = cannon.component(ofType: AmmoComponent.self)
        else {
            return
        }
        print("ding!")
        ammoComponent.ammo += 1
        entities.first?.removeComponent(ofType: DidHitComponent.self)
    }
}
