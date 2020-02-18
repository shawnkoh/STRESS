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

    static let selectedPegToolBorderWidth: CGFloat = 2
    static let selectedPegToolBorderColor: CGColor = UIColor.red.cgColor

    static let defaultBackgroundImage = UIImage(named: "background")!
    static let defaultLoadedCannonImage = UIImage(named: "cannon-loaded")!
    static let defaultEmptyCannonImage = UIImage(named: "cannon-empty")!
    static let defaultCannonSize = CGSize(width: 64, height: 64)

    static let defaultPegRadius: CGFloat = 16
    static var defaultPegSize: CGSize {
        CGSize(width: defaultPegRadius * 2, height: defaultPegRadius * 2)
    }
    static let defaultPegFadeDuration: TimeInterval = 0.8
    static let objectivePegImage = UIImage(named: "peg-orange")!
    static let objectivePegHitImage = UIImage(named: "peg-orange-glow")!
    static let normalPegImage = UIImage(named: "peg-blue")!
    static let normalPegHitImage = UIImage(named: "peg-blue-glow")!
    static func defaultPegImage(for type: PegType, didHit: Bool = false) -> UIImage {
        switch type {
        case .objective:
            return didHit ? objectivePegHitImage : objectivePegImage
        case .normal:
            return didHit ? normalPegHitImage : normalPegImage
        }
    }

    static let defaultBallImage = UIImage(named: "ball")!
    static let defaultBallRadius: CGFloat = 12

    /// Constraints the cannon's shooting angle.
    static let cannonShootingAngleConstraint = CGFloat(60)

    static let defaultBallSpeed = CGFloat(8)
}
