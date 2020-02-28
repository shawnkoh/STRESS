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
    }
}
