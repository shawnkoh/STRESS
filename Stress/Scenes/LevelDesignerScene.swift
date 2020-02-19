//
//  LevelDesignerScene.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class LevelDesignerScene: GKScene {
    let levelDesigner: LevelDesigner
    let background: UIImageView

    override init(size: CGSize) {
        background = UIImageView(frame: .zero)
        background.image = StressSettings.defaultBackgroundImage
        background.contentMode = .scaleAspectFill
        background.center = CGPoint(x: size.width / 2, y: size.height / 2)
        background.bounds.size = size
        background.isUserInteractionEnabled = true
        levelDesigner = LevelDesigner(size: size)
        super.init(size: size)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        entities
            .compactMap { $0.component(ofType: VisualComponent.self)?.view }
            .forEach { view.addSubview($0) }
        _ = background.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        _ = background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        _ = background.topAnchor.constraint(equalTo: view.topAnchor)
        _ = background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }
}
