//
//  DraggableComponent.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class DraggableComponent: GKComponent {
    var canDragTo: (_ location: CGPoint) -> Bool
    unowned var transformComponent: TransformComponent {
        guard let transformComponent = entity?.component(ofType: TransformComponent.self) else {
            fatalError("The entity must have a transform component in order to be draggable")
        }
        return transformComponent
    }
    unowned var visualComponent: VisualComponent {
        guard let visualComponent = entity?.component(ofType: VisualComponent.self) else {
            fatalError("The entity must have a Visual component in order to be draggable")
        }
        return visualComponent
    }

    init(canDragTo: @escaping (CGPoint) -> Bool) {
        self.canDragTo = canDragTo
        super.init()
    }

    override func didAddToEntity() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        visualComponent.view.addGestureRecognizer(panGestureRecognizer)
        visualComponent.view.isUserInteractionEnabled = true
    }

    @objc func drag(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: visualComponent.view.superview)
        guard canDragTo(location) else {
            return
        }
        transformComponent.position = location
    }
}
