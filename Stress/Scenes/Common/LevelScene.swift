//
//  LevelScene.swift
//  Stress
//
//  Created by Shawn Koh on 23/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

class LevelScene: GKScene {
    override init() {
        super.init()
        addSystem(VisualSystem(scene: self))
        addSystem(TransformSystem(scene: self))
        addSystem(CleanupVisualSystem(scene: self))
        addSystem(DestroySystem(scene: self))
    }
}
