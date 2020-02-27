//
//  Cannon.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/**
 `Cannon` is an entity that represents a cannon in Stress.
*/
class Cannon: GKEntity {
    init(center: CGPoint, size: CGSize) {
        super.init()

        let transformComponent = TransformComponent(position: center)
        addComponent(transformComponent)

        let view = UIImageView(frame: .zero)
        view.image = StressSettings.defaultEmptyCannonImage
        view.bounds.size = size
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        addComponent(RotatableComponent())

        let firingComponent = FiringComponent(projectileConstructor: {
            Ball(center: .zero, velocity: .zero)
        })
        addComponent(firingComponent)

        addComponent(AmmoComponent(ammo: StressSettings.cannonAmmo))
    }
}
