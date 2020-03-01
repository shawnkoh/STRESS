//
//  BKPhysicsWorld.swift
//  Bounce
//
//  Created by Shawn Koh on 11/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// The world the physics simulation is run in.
class BKPhysicsWorld {
    /**
     A vector that specifies the gravitational acceleration applied to physics bodies in the physics world.

     https://en.wikipedia.org/wiki/Gravity_of_Earth
     SI Unit: m/s^2
     */
    var gravity: CGVector = .init(dx: 0, dy: 9.806_65)
    /**
     The density of air or atmospheric density, denoted ρ (Greek: rho),
     is the mass per unit volume of Earth's atmosphere.

     https://en.wikipedia.org/wiki/Density_of_air
     SI Unit: kg/m^3
     */
    var airDensity: CGFloat = 1.225
    var bodies: [BKPhysicsBody] = .init()
    weak var contactDelegate: BKPhysicsContactDelegate?

    init() {}

    func addBody(_ body: BKPhysicsBody) {
        bodies.append(body)
    }

    @discardableResult
    func removeBody(_ body: BKPhysicsBody) -> BKPhysicsBody? {
        guard let index = bodies.firstIndex(of: body) else {
            return nil
        }
        return bodies.remove(at: index)
    }

    /**
     Advances the physics world.
     - Parameters:
        - timestep: The time to advance by, in seconds.
     */
    func simulate(timestep: CGFloat) {
        bodies.filter { !$0.isResting }
            .compactMap { $0 as? BKPhysicsBodyWithVolume }
            .filter { $0.isDynamic }
            .forEach { body in
                let resultantAcceleration = calculateResultantAcceleration(on: body)
                // TODO: Use Velocity Verlet to calculate the new velocity instead to make it more accurate.
                // https://en.wikipedia.org/wiki/Verlet_integration#Velocity_Verlet
                let deltaVelocity = resultantAcceleration * timestep
                body.velocity += deltaVelocity
                let initialPosition = body.center

                // Multiply by 100 to convert velocity from m/s to cm/s since 1 point = 1 cm
                body.center += body.velocity * 100 * timestep
                let didCollide = processCollisions(with: body)
                if didCollide {
                    let distanceMoved = initialPosition.distance(to: body.center)
                    updateIsResting(for: body, distanceMoved: distanceMoved)
                }
            }
    }

    private func computeWeightForce(for body: BKPhysicsBodyWithVolume) -> CGVector {
        gravity * body.mass
    }

    private func computeDragForce(for body: BKPhysicsBodyWithVolume) -> CGVector {
        // swiftlint:disable line_length
        // https://www.khanacademy.org/computing/computer-programming/programming-natural-simulations/programming-forces/a/air-and-fluid-resistance
        // swiftlint:enable line_length
        // https://en.wikipedia.org/wiki/Drag_equation
        // Divide by 10_000 to convert area from m^2 to cm^2
        CGVector(dx: 0,
                 dy: CGFloat(-0.5) * airDensity *
                    body.velocity.dy * body.velocity.dy *
                    body.dragCoefficient *
                    (body.area / 10_000))
    }

    private func calculateResultantAcceleration(on body: BKPhysicsBodyWithVolume) -> CGVector {
        let weightForce = computeWeightForce(for: body)
        let dragForce = computeDragForce(for: body)
        let resultantForce = weightForce + dragForce
        let resultantAcceleration = resultantForce / body.mass
        return resultantAcceleration
    }

    private func processCollisions(with body: BKPhysicsBodyWithVolume) -> Bool {
        var didCollide = false
        for neighbour in bodies where neighbour != body {
            guard let contactPosition = body.computePositionWhenContacting(with: neighbour) else {
                continue
            }
            didCollide = true

            if let neighbour = neighbour as? BKPhysicsBodyWithVolume {
                let collisionVectors = body.computeCollisionVectors(with: neighbour)
                body.velocity = collisionVectors.0
                neighbour.velocity = collisionVectors.1
            } else {
                let collisionVector = body.computeCollisionVector(with: neighbour)
                body.velocity = collisionVector
            }
            guard let physicsContact = body.computeContact(with: neighbour) else {
                fatalError("Unable to initialise a PhysicsContact")
            }

            body.center = contactPosition
            // TODO: Calculate amount of time taken to hit the contact position to be more accurate

            contactDelegate?.didBegin(physicsContact)
            neighbour.isResting = false
        }
        return didCollide
    }

    private func updateIsResting(for body: BKPhysicsBodyWithVolume, distanceMoved: CGFloat) {
        if distanceMoved < BKSettings.restingDistanceMovedThreshold {
            body.restingCount += 1
        } else {
            body.restingCount = 0
        }
        if body.restingCount == BKSettings.restingCountThreshold {
            body.isResting = true
            body.restingCount = 0
        }
        // TODO: Move the body to a proper resting spot
    }
}
