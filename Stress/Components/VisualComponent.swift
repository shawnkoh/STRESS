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

    override func didAddToEntity() {
        entity?.scene?.view?.addSubview(view)
    }

    override func willRemoveFromEntity() {
        view.removeFromSuperview()
    }
}

extension VisualComponent: BKPhysicsBodyDelegate {
    func didUpdate(body: BKPhysicsBody) {
        if let body = body as? BKPhysicsBodyWithVolume {
            view.center = body.center
        }
    }
}
