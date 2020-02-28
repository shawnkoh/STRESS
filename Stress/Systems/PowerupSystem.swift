//
//  PowerupSystem.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PowerupSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [PowerupComponent.self, DidHitComponent.self])
    }
}
