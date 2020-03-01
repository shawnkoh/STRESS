//
//  AttachVisualSystem.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class AttachVisualSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene,
                   requiredComponents: [VisualComponent.self],
                   excludedComponents: [DidAttachVisualComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities.forEach { entity in
            guard let view = entity.component(ofType: VisualComponent.self)?.view else {
                fatalError("Could not access visual component")
            }
            guard let parent = scene.view else {
                return
            }

            parent.addSubview(view)
            entity.addComponent(DidAttachVisualComponent())
        }
    }
}
