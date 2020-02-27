//
//  LevelData.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import RealmSwift

/**
 `LevelData` represents a data model object for the abstract data structure `Level`.
 It is intended to be used for persisting `Level`s.
*/
class LevelData: Object {
    override class func primaryKey() -> String? {
        "id"
    }

    // Realm has no auto-incrementing properties, so generate a unique string ID.
    // More info here: https://realm.io/docs/swift/latest#limitations-models
    @objc dynamic var id = UUID().uuidString
    // Realm requires all non optional properties to have a default value.
    // https://realm.io/docs/swift/latest/#models
    @objc dynamic var name: String = Settings.Level.name
    @objc dynamic var width = Double(Settings.Level.size.width)
    @objc dynamic var height = Double(Settings.Level.size.height)
    let pegs: List<PegData>

    required init() {
        self.pegs = List()
        super.init()
    }

    init(id: String, name: String, width: Double, height: Double, pegs: List<PegData>) {
        self.id = id
        self.name = name
        self.width = width
        self.height = height
        self.pegs = pegs
        super.init()
    }

    /// Constructs a new `LevelData`.
    /// - Parameter level: A `Level` abstract data structure.
    convenience init(level: Level) {
        let pegDatas = level.pegs.map { PegData(peg: $0) }
        let pegs = List<PegData>()
        pegs.append(objectsIn: pegDatas)
        self.init(id: level.id,
                  name: level.name,
                  width: Double(level.size.width),
                  height: Double(level.size.height),
                  pegs: pegs)
    }
}
