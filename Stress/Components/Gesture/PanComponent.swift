//
//  PanComponent.swift
//  Stress
//
//  Created by Shawn Koh on 2/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class PanComponent: GKComponent {
    let gestureRecognizer = UIPanGestureRecognizer()
    let action: (UIGestureRecognizer) -> Void

    init(action: @escaping (UIGestureRecognizer) -> Void) {
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

    @objc private func interact(_ sender: UIPanGestureRecognizer) {
        action(sender)
    }
}
