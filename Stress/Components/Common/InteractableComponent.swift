//
//  InteractableComponent.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

// The rationale for this component is because the gesture recognizer's @objc action cannot easily access the entity.
class InteractableComponent: GKComponent {
    let gestureRecognizer: UIGestureRecognizer
    let action: (UIGestureRecognizer) -> Void

    init(gestureRecognizer: UIGestureRecognizer, action: @escaping (UIGestureRecognizer) -> Void) {
        self.gestureRecognizer = gestureRecognizer
        self.action = action
        super.init()
    }

    override func didAddToEntity(_ entity: GKEntity) {
        guard let view = entity.component(ofType: VisualComponent.self)?.view else {
            fatalError("InteractableComponent requires an entity with a VisualComponent")
        }

        view.isUserInteractionEnabled = true
        gestureRecognizer.addTarget(self, action: #selector(interact(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }

    @objc private func interact(_ sender: UIGestureRecognizer) {
        action(sender)
    }
}
