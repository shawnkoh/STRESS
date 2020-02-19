//
//  TitleScreenScene.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class TitleScreen: GKScene {
    unowned let stress: Stress
    let background: UIImageView

    init(stress: Stress, size: CGSize) {
        self.stress = stress
        background = UIImageView(frame: .zero)
        background.image = StressSettings.defaultBackgroundImage
        background.contentMode = .scaleAspectFill
        background.center = CGPoint(x: size.width / 2, y: size.height / 2)
        background.bounds.size = size
        background.isUserInteractionEnabled = true
        super.init(size: size)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        _ = background.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        _ = background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        _ = background.topAnchor.constraint(equalTo: view.topAnchor)
        _ = background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }
}
