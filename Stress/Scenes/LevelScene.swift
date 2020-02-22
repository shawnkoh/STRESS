//
//  LevelScene.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class LevelScene: GKScene {
    var name: String
    init(size: CGSize, name: String = StressSettings.defaultLevelName) {
        self.name = name
        super.init(size: size)
    }
}
