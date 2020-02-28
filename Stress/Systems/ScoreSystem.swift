//
//  ScoreSystem.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class ScoreSystem: GKSystem {
    private(set) var score: Int = 0

    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [ScoreComponent.self,
                                                    DidHitComponent.self,
                                                    WillDestroyComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        var sum = 0
        var count = 0
        entities
            .compactMap { $0.component(ofType: ScoreComponent.self) }
            .forEach {
                sum += $0.score
                count += 1
            }
        score += sum * count
    }
}
