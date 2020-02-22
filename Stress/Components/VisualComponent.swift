//
//  VisualComponent.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/**
 A `VisualComponent` is a component that attaches to a `GKEntity`.
 It enables the entity to be rendered in Stress.
 */
class VisualComponent: GKComponent {
    let view: UIView

    init(view: UIView) {
        self.view = view
        super.init()
    }

    override func didAddToScene(_ scene: GKScene) {
        scene.view?.addSubview(view)

        if let transformComponent = entity?.component(ofType: TransformComponent.self) {
            view.center = transformComponent.position
        }
    }

    override func willRemoveFromScene(_ scene: GKScene) {
        view.removeFromSuperview()
    }

    override func willRemoveFromEntity(_ entity: GKEntity) {
        view.removeFromSuperview()
    }
}
