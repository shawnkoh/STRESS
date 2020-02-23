//
//  LevelScene.swift
//  Stress
//
//  Created by Shawn Koh on 23/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

class LevelScene: GKScene {}

extension LevelScene: LevelDelegate {
    func didAddPeg(_ peg: Peg) {
        addEntity(peg)
    }

    func didRemovePeg(_ peg: Peg) {
        removeEntity(peg)
    }
}
