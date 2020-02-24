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
    /// Convenience variable to access the cannon's image view
    var view: UIImageView {
        guard let view = component(ofType: VisualComponent.self)?.view as? UIImageView else {
            fatalError("Cannon's image view could not be accessed")
        }
        return view
    }
    /// Convenience variable to access the cannon's center
    var center: CGPoint {
        view.center
    }

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
    }
}
