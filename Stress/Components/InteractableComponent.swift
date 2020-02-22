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

    private unowned var visualComponent: VisualComponent {
        guard let visualComponent = entity?.component(ofType: VisualComponent.self) else {
            fatalError("InteractableComponent requires an entity with a VisualComponent")
        }
        return visualComponent
    }

    init(gestureRecognizer: UIGestureRecognizer, action: @escaping (UIGestureRecognizer) -> Void) {
        self.gestureRecognizer = gestureRecognizer
        self.action = action
        super.init()
    }

    override func didAddToEntity(_ entity: GKEntity) {
        visualComponent.view.isUserInteractionEnabled = true
        gestureRecognizer.addTarget(self, action: #selector(interact(_:)))
        visualComponent.view.addGestureRecognizer(gestureRecognizer)
    }

    @objc private func interact(_ sender: UIGestureRecognizer) {
        action(sender)
    }
}
