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
    var type: PegType

    var isHit: Bool {
        didSet {
            guard
                let visualComponent = component(ofType: VisualComponent.self),
                let imageView = visualComponent.view as? UIImageView
            else {
                fatalError("Peg must have a VisualComponent")
            }
            imageView.image = StressSettings.defaultPegImage(for: type, didHit: isHit)
        }
    }

    init(center: CGPoint, type: PegType, radius: CGFloat = StressSettings.defaultPegRadius) {
        self.type = type
        self.isHit = false
        super.init()

        let transformComponent = TransformComponent(position: center)
        addComponent(transformComponent)

        let view = PegView(type: type)
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        let physicsBody = BKPhysicsCircle(center: center, radius: radius, isDynamic: false, isResting: false)
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody)
        addComponent(physicsComponent)
    }
}

/**
 The `PegType` enumeration represents the various types of pegs in Stress.
 */
enum PegType: Int {
    /// An `objective` peg has to be eliminated in order to complete the level.
    /// When it is eliminated, it provides points.
    case objective
    /// A `normal` peg does not need to be eliminated in order to complete the level.
    /// When it is eliminated, it provides points.
    case normal
}

extension Peg: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
