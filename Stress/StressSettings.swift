//
//  StressSettings.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

// Global level settings for the `Stress` application.
enum StressSettings {
    static let defaultUpdateFrequency: Int = 4

    static let defaultLevelName: String = "Level Name"
    static let pegsOnAxis: Int = 40
    static let defaultLevelSize = CGSize(width: CGFloat(pegsOnAxis) * defaultPegRadius,
                                         height: CGFloat(pegsOnAxis) * defaultPegRadius)

    static let selectedPegToolBorderWidth: CGFloat = 2
    static let selectedPegToolBorderColor: CGColor = UIColor.red.cgColor

    static let defaultBackgroundImage = UIImage(named: "background")!

    static let defaultLoadedCannonImage = UIImage(named: "cannon-loaded")!
    static let defaultEmptyCannonImage = UIImage(named: "cannon-empty")!
    static let defaultCannonSize = CGSize(width: 96, height: 96)
    static let cannonMaxAngle: CGFloat = .pi / 2
    static let cannonMinAngle: CGFloat = -.pi / 2
    static let cannonSensitivity: CGFloat = 0.3
    static let cannonAmmo: Int = 10

    static let defaultPegRadius: CGFloat = 20
    static var defaultPegSize: CGSize {
        CGSize(width: defaultPegRadius * 2, height: defaultPegRadius * 2)
    }
    static let defaultPegFadeDuration: TimeInterval = 0.8

    static let circleObjectivePegImage = UIImage(named: "peg-orange")!
    static let circleObjectivePegHitImage = UIImage(named: "peg-orange-glow")!
    static let circlePegImage = UIImage(named: "peg-blue")!
    static let circlePegHitImage = UIImage(named: "peg-blue-glow")!

    static let triangleObjectivePegImage = UIImage(named: "peg-orange-triangle")!
    static let triangleObjectivePegHitImage = UIImage(named: "peg-orange-glow-triangle")!
    static let trianglePegImage = UIImage(named: "peg-blue-triangle")!
    static let trianglePegHitImage = UIImage(named: "peg-blue-glow-triangle")!

    static func defaultPegImage(for shape: PegShape, isObjective: Bool = false, didHit: Bool = false) -> UIImage {
        switch shape {
        case .circle:
            if isObjective {
                return didHit ? circleObjectivePegHitImage : circleObjectivePegImage
            } else {
                return didHit ? circlePegHitImage : circlePegImage
            }
        case .triangle:
            if isObjective {
                return didHit ? triangleObjectivePegHitImage : triangleObjectivePegImage
            } else {
                return didHit ? trianglePegHitImage : trianglePegImage
            }
        }
    }

    static let defaultBallImage = UIImage(named: "ball")!
    static let defaultBallRadius: CGFloat = 12

    /// Constraints the cannon's shooting angle.
    static let cannonShootingAngleConstraint = CGFloat(60)

    static let defaultBallSpeed = CGFloat(8)
}
