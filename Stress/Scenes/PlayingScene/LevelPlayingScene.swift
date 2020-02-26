//
//  LevelPlayingScene.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

class LevelPlayingScene: GKScene {
    unowned var level: Level
    lazy var cannonControlSystem = CannonControlSystem(scene: self)

    init(level: Level) {
        self.level = level
        super.init()
        addSystem(TransformSystem(scene: self))
        addSystem(CollisionSystem(scene: self))
        addSystem(ScoreSystem(scene: self))
        addSystem(DestroySystem(scene: self))
        addSystem(cannonControlSystem)
    }

    override func didMove(to view: GKView) {
        cannonControlSystem.controller = view
        let size = level.size
        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: size.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: size.height)
        let bottomRight = CGPoint(x: size.width, y: size.height)
        let cannon = Cannon(center: CGPoint(x: level.size.width / 2, y: 80), size: StressSettings.defaultCannonSize)
        let topWall = Wall(from: topLeft, to: topRight)
        let leftWall = Wall(from: topLeft, to: bottomLeft)
        let rightWall = Wall(from: topRight, to: bottomRight)
        let exit = Exit(from: bottomLeft, to: bottomRight)
        addEntity(cannon)
        addEntity(topWall)
        addEntity(leftWall)
        addEntity(rightWall)
        addEntity(exit)
    }
}