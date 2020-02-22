//
//  SelectingLevelScene.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class SelectingLevelScene: GKScene {
    unowned let stress: Stress
    let background = Background()
    let stage = Stage()
    let level: LevelScene

    init(stress: Stress, size: CGSize) {
        self.stress = stress
        level = LevelScene(size: size)

        super.init(size: size)

    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        view.addSubview(stage)
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }

    @objc func tapBack() {
        stress.sceneStateMachine.enter(TitleScreenState.self)
    }

    @objc func tapReset() {
        level.entities(ofType: Peg.self).forEach {
            level.removeEntity($0)
        }
    }

    @objc func tapLoad() {
    }

    @objc func tapSave() {
    }

    @objc func tapPlay() {
    }
}
