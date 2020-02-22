//
//  LevelScene.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit
import RealmSwift

class LevelScene: GKScene {
    var name: String
    init(size: CGSize, name: String = StressSettings.defaultLevelName) {
        self.name = name
        super.init(size: size)
    }

    func constructLevelData() -> LevelData {
        let pegDatas = entities(ofType: Peg.self)
            .map { $0.save() }
            .compactMap { $0 as? PegData }
        let pegs: List<PegData> = List()
        // TODO: Might be problematic because we need to do this in a realm
        pegs.append(objectsIn: pegDatas)
        let levelData = LevelData(id: id,
                                  name: name,
                                  width: Double(size.width),
                                  height: Double(size.height),
                                  pegs: pegs)
        return levelData
    }
}
