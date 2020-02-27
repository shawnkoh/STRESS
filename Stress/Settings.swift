//
//  Settings.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

// Global level settings for the `Stress` application.
enum Settings {
    static let defaultUpdateFrequency: Int = 4

    static let defaultLevelName: String = "Level Name"
    static let pegsOnAxis: Int = 40
    static let defaultLevelSize = CGSize(width: CGFloat(pegsOnAxis) * Settings.Peg.radius,
                                         height: CGFloat(pegsOnAxis) * Settings.Peg.radius)

    static let selectedPegToolBorderWidth: CGFloat = 2
    static let selectedPegToolBorderColor: CGColor = UIColor.red.cgColor

    static let defaultBackgroundImage = UIImage(named: "background")!

    enum Bucket {
        static let image = UIImage(named: "bucket")!
    }

    enum Peg {
        static let radius: CGFloat = 20
        static var size: CGSize {
            CGSize(width: radius * 2, height: radius * 2)
        }
        static let fadeDuration: TimeInterval = 0.8

        static let circleObjectiveImage = UIImage(named: "peg-orange")!
        static let circleObjectiveHitImage = UIImage(named: "peg-orange-glow")!
        static let circleImage = UIImage(named: "peg-blue")!
        static let circleHitImage = UIImage(named: "peg-blue-glow")!

        static let triangleObjectiveImage = UIImage(named: "peg-orange-triangle")!
        static let triangleObjectiveHitImage = UIImage(named: "peg-orange-glow-triangle")!
        static let triangleImage = UIImage(named: "peg-blue-triangle")!
        static let triangleHitImage = UIImage(named: "peg-blue-glow-triangle")!

        static func image(for shape: PegShape, isObjective: Bool = false, didHit: Bool = false) -> UIImage {
            switch shape {
            case .circle:
                if isObjective {
                    return didHit ? circleObjectiveHitImage : circleObjectiveImage
                } else {
                    return didHit ? circleHitImage : circleImage
                }
            case .triangle:
                if isObjective {
                    return didHit ? triangleObjectiveHitImage : triangleObjectiveImage
                } else {
                    return didHit ? triangleHitImage : triangleImage
                }
            }
        }
    }

    enum Cannon {
        static let loadedImage = UIImage(named: "cannon-loaded")!
        static let emptyImage = UIImage(named: "cannon-empty")!
        static let size = CGSize(width: 96, height: 96)
        static let maxAngle: CGFloat = .pi / 2
        static let minAngle: CGFloat = -.pi / 2
        static let sensitivity: CGFloat = 0.3
        static let ammo: Int = 10
    }

    static let defaultBallImage = UIImage(named: "ball")!
    static let defaultBallRadius: CGFloat = 12

    /// Constraints the cannon's shooting angle.
    static let cannonShootingAngleConstraint = CGFloat(60)

    static let defaultBallSpeed = CGFloat(8)
}
