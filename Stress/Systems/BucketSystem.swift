//
//  BucketSystem.swift
//  Stress
//
//  Created by Shawn Koh on 28/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class BucketSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [BucketComponent.self])
    }

    private var walls: [Wall] {
        entities.compactMap { $0 as? Wall }
    }

    override func update(deltaTime: TimeInterval) {
        guard
            let bucket = entities.first( where: { $0 is Bucket }) as? Bucket,
            let stage = scene.view,
            let leftWall = walls[0].component(ofType: PhysicsComponent.self)?.physicsBody as? BKPhysicsEdge,
            let rightWall = walls[1].component(ofType: PhysicsComponent.self)?.physicsBody as? BKPhysicsEdge
        else {
            return
        }
        guard
            let bucketComponent = bucket.component(ofType: BucketComponent.self),
            let transformComponent = bucket.component(ofType: TransformComponent.self),
            let view = bucket.component(ofType: VisualComponent.self)?.view,
            let physicsEdge = bucket.component(ofType: PhysicsComponent.self)?.physicsBody as? BKPhysicsEdge
        else {
            fatalError("Unable to access required components")
        }

        let bucketSize = view.frame.size
        let stageSize = stage.frame.size
        let minX = bucketSize.width / 2
        let maxX = stageSize.width - minX

        if bucketComponent.isMovingRight {
            if transformComponent.position.x <= maxX {
                transformComponent.position.x += 5
            } else {
                transformComponent.position.y -= 5
                bucketComponent.isMovingRight = false
            }
        } else {
            if transformComponent.position.x >= minX {
                transformComponent.position.x -= 5
            } else {
                transformComponent.position.x += 5
                bucketComponent.isMovingRight = true
            }
        }
        transformComponent.position.y = stageSize.height - bucketSize.height / 2

        physicsEdge.from = transformComponent.position +
            CGVector(dx: -bucketSize.width / 2, dy: bucketSize.height / 2 - 5)
        physicsEdge.to = transformComponent.position +
            CGVector(dx: bucketSize.width / 2, dy: bucketSize.height / 2 - 5)

        leftWall.from = transformComponent.position +
            CGVector(dx: -bucketSize.width / 2, dy: bucketSize.height / 2)
        leftWall.to = transformComponent.position +
            CGVector(dx: -bucketSize.width / 2 + 20, dy: -bucketSize.height / 2 + 12)

        rightWall.from = transformComponent.position +
            CGVector(dx: bucketSize.width / 2, dy: bucketSize.height / 2)
        rightWall.to = transformComponent.position +
            CGVector(dx: bucketSize.width / 2 - 20, dy: -bucketSize.height / 2 + 12)

        drawDebugLines()
    }

    private var leftLine = CAShapeLayer()
    private var rightLine = CAShapeLayer()
    private var exitLine = CAShapeLayer()

    private func drawDebugLines() {
        guard
            let leftWall = walls[0].component(ofType: PhysicsComponent.self)?.physicsBody as? BKPhysicsEdge,
            let rightWall = walls[1].component(ofType: PhysicsComponent.self)?.physicsBody as? BKPhysicsEdge,
            let bucket = entities.first(where: { $0 is Bucket }),
            let exit = bucket.component(ofType: PhysicsComponent.self)?.physicsBody as? BKPhysicsEdge
        else {
            return
        }

        let leftLinePath = UIBezierPath()
        leftLinePath.move(to: leftWall.from)
        leftLinePath.addLine(to: leftWall.to)
        leftLine.path = leftLinePath.cgPath
        leftLine.fillColor = nil
        leftLine.opacity = 1
        leftLine.strokeColor = UIColor.red.cgColor
        scene.view?.layer.addSublayer(leftLine)

        let rightLinePath = UIBezierPath()
        rightLinePath.move(to: rightWall.from)
        rightLinePath.addLine(to: rightWall.to)
        rightLine.path = rightLinePath.cgPath
        rightLine.fillColor = nil
        rightLine.opacity = 1
        rightLine.strokeColor = UIColor.red.cgColor
        scene.view?.layer.addSublayer(rightLine)

        let exitLinePath = UIBezierPath()
        exitLinePath.move(to: exit.from)
        exitLinePath.addLine(to: exit.to)
        exitLine.path = exitLinePath.cgPath
        exitLine.fillColor = nil
        exitLine.opacity = 1
        exitLine.strokeColor = UIColor.red.cgColor
        scene.view?.layer.addSublayer(exitLine)
    }
}
