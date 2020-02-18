//
//  BKView.swift
//  Bounce
//
//  Created by Shawn Koh on 15/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// A view subclass that renders a BounceKit scene.
class GKView: UIView {
    /// The scene currently presented by this view.
    private(set) var scene: GKScene?
    private var displayLink: CADisplayLink?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isUserInteractionEnabled = true
    }

    /// Presents a scene.
    /// - Parameter scene: The scene to present.
    func presentScene(_ scene: GKScene) {
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }

        self.scene = scene
        scene.view = self

        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(updateScene(displayLink:)))
        displayLink?.add(to: .current, forMode: .common)
    }

    @objc func updateScene(displayLink: CADisplayLink) {
        let deltaTime = CGFloat(displayLink.targetTimestamp - displayLink.timestamp) // in seconds
        scene?.update(timestep: deltaTime, updateFrequency: StressSettings.defaultUpdateFrequency)
    }
}
