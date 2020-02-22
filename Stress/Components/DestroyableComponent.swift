//
//  DestroyableComponent.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class DestroyableComponent: GKComponent {
    unowned var visualComponent: VisualComponent {
        guard let visualComponent = entity?.component(ofType: VisualComponent.self) else {
            fatalError("The entity must have a Visual component in order to be destroyable")
        }
        return visualComponent
    }

    override func didAddToEntity() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(destroy(_:)))
        visualComponent.view.addGestureRecognizer(gestureRecognizer)
        visualComponent.view.isUserInteractionEnabled = true
    }

    @objc func destroy(_ sender: UIPanGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }
        guard let entity = entity else {
            fatalError("The DestroyableComponent has not yet been added to an entity.")
        }
        entity.scene?.removeEntity(entity)
    }
}
