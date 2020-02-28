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

    enum Level {
        static let name: String = "Level Name"
        static let pegsOnAxis: Int = 40
        static let size = CGSize(width: CGFloat(pegsOnAxis) * Peg.radius,
                                 height: CGFloat(pegsOnAxis) * Peg.radius)
    }

    static let selectedPegToolBorderWidth: CGFloat = 2
    static let selectedPegToolBorderColor: CGColor = UIColor.red.cgColor

    enum Background {
        static let image = UIImage(named: "background")!
    }

    enum Bucket {
        static let image = UIImage(named: "bucket")!
    }

    enum Peg {
        static let radius: CGFloat = 20
        static var size: CGSize {
            CGSize(width: radius * 2, height: radius * 2)
        }
        static let fadeDuration: TimeInterval = 0.8

        static func score(for type: PegType) -> Int {
            switch type {
            case .blue:
                return 10
            case .green:
                return 10
            case .orange:
                return 100
            }
        }

        static func image(type: PegType, shape: PegShape, didHit: Bool = false) -> UIImage {
            var path = "peg"

            switch type {
            case .blue:
                path += "-blue"
            case .green:
                path += "-green"
            case .orange:
                path += "-orange"
            }

            if didHit {
                path += "-glow"
            }

            switch shape {
            case .circle:
                ()
            case .triangle:
                path += "-triangle"
            }

            return UIImage(named: path)!
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

    enum Ball {
        static let image = UIImage(named: "ball")!
        static let radius: CGFloat = 12
        static let speed = CGFloat(8)
    }

    enum Powerup {
        static let spaceBlastRadius = Peg.radius * 3
    }
}
