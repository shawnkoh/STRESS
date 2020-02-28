//
//  PegHitSystem.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

class PegHitSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [PegComponent.self, VisualComponent.self, DidHitComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach { peg in
            guard
                let pegComponent = peg.component(ofType: PegComponent.self),
                let view = peg.component(ofType: VisualComponent.self)?.view as? UIImageView
            else {
                fatalError("Unable to access components")
            }

            view.image = Settings.Peg.image(type: pegComponent.type, shape: pegComponent.shape, didHit: true)
        }
    }
}
