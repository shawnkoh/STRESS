//
//  Stage.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Stage: GKView {
    var size: CGSize

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    init(size: CGSize) {
        self.size = size
        super.init()
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.cornerRadius = 16
    }

    func presentLevel(_ level: Level) {
        let widthRatio = size.width / level.size.width
        let heightRatio = size.height / level.size.height

        let levelScene = LevelScene()
        level.pegs.forEach { peg in
            guard
                let transformComponent = peg.component(ofType: TransformComponent.self),
                let view = peg.component(ofType: VisualComponent.self)?.view
            else {
                fatalError("Unable to access peg's position")
            }
            let position = transformComponent.position
            let scaledPosition = CGPoint(x: position.x * widthRatio, y: position.y * heightRatio)
            transformComponent.position = scaledPosition
            view.frame.size.width *= widthRatio
            view.frame.size.height *= heightRatio
            levelScene.addEntity(peg)
        }
        presentScene(levelScene)
    }

    override func didMoveToSuperview() {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width)
        ])
    }
}
