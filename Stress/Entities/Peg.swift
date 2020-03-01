//
//  Peg.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/**
 `Peg` is an entity that represents a peg in Stress.
*/
class Peg: GKEntity {
    init(type: PegType, position: CGPoint, view: UIView, physicsBody: BKPhysicsBody) {
        super.init()
        addComponent(PegComponent(type: type))

        switch type {
        case .orange:
            addComponent(ObjectiveComponent())
        case .green:
            addComponent(SpaceBlastComponent())
        case .red:
            addComponent(SpookyBallComponent())
        case .blue:
            ()
        }

        let score = Settings.Peg.score(for: type)
        addComponent(ScoreComponent(score: score))
        addComponent(TransformComponent(position: position))
        addComponent(VisualComponent(view: view))
        addComponent(PhysicsComponent(physicsBody: physicsBody))
    }
}

extension Peg: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
