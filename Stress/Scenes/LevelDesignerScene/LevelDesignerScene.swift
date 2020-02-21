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
    let background = Background()
    let palette = Palette()

    override init(size: CGSize) {
        levelDesigner = LevelDesigner(size: size)

        super.init(size: size)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        view.addSubview(palette)
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }
}
