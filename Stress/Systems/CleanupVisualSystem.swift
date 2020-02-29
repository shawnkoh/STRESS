//
//  CleanupVisualSystem.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class CleanupVisualSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene,
                   requiredComponents: [VisualComponent.self,
                                        DidAttachVisualComponent.self,
                                        WillDestroyComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach { entity in
            guard let view = entity.component(ofType: VisualComponent.self)?.view else {
                fatalError("Unable to access entity's Visual Component")
            }

            view.removeFromSuperview()

            entity.removeComponent(ofType: DidAttachVisualComponent.self)
        }
    }
}
