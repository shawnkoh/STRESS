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
    /// The current angle of the cannon
    private var angle = CGFloat.pi * 0.5

    init(center: CGPoint, size: CGSize) {
        super.init()

        let view = UIImageView(frame: .zero)
        view.image = StressSettings.defaultEmptyCannonImage
        view.center = center
        view.bounds.size = size
        let visualComponent = VisualComponent(view: view)
        addComponent(visualComponent)

        let firingComponent = FiringComponent(projectileConstructor: {
            let dx = StressSettings.defaultBallSpeed * cos(self.angle)
            let dy = StressSettings.defaultBallSpeed * sin(self.angle)
            let velocity = CGVector(dx: dx, dy: dy)
            let ball = Ball(center: center, velocity: velocity)
            return ball
        })
        addComponent(firingComponent)
    }

    /// Rotates the cannon so that it faces the given point.
    /// - Parameter point: The point that the cannon is to face.
    func rotate(to point: CGPoint) {
        let newAngle = shootingAngle(to: point)
        view.transform = view.transform.rotated(by: newAngle - angle)
        angle = newAngle
    }

    /// Calculates the constrained angle from the cannon to a point.
    /// - Parameter point: The point to shoot towards.
    /// - Returns: The angle to fire at.
    private func shootingAngle(to point: CGPoint) -> CGFloat {
        let deltaX = point.x - center.x
        let deltaY = point.y - center.y
        let newDeltaY = max(deltaY, StressSettings.cannonShootingAngleConstraint)
        return atan2(newDeltaY, deltaX)
    }
}
