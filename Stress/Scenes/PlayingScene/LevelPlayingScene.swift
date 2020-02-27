//
//  LevelPlayingScene.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

class LevelPlayingScene: GKScene {
    unowned let parent: PlayingScene
    unowned var level: Level
    lazy var cannonControlSystem = CannonControlSystem(scene: self)
    lazy var scoreSystem = ScoreSystem(scene: self)

    init(parent: PlayingScene, level: Level) {
        self.parent = parent
        self.level = level
        super.init()
        addSystem(VisualSystem(scene: self))
        addSystem(PhysicsSystem(scene: self))
        addSystem(cannonControlSystem)
        addSystem(TransformSystem(scene: self))
        addSystem(CollisionSystem(scene: self))
        addSystem(scoreSystem)
        addSystem(CleanupVisualSystem(scene: self))
        addSystem(CleanupPhysicsSystem(scene: self))
        addSystem(DestroySystem(scene: self))
        addSystem(LoseSystem(scene: self))
        addSystem(WinSystem(scene: self))
    }

    override func didMove(to view: GKView) {
        cannonControlSystem.controller = view
        let size = level.size
        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: size.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: size.height)
        let bottomRight = CGPoint(x: size.width, y: size.height)
        let cannon = Cannon(center: CGPoint(x: level.size.width / 2, y: 80), size: Settings.Cannon.size)
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
