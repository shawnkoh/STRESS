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
    let circlePegs: List<CirclePegData>
    let trianglePegs: List<TrianglePegData>

    required init() {
        self.circlePegs = List()
        self.trianglePegs = List()
        super.init()
    }

    init(id: String,
         name: String,
         width: Double,
         height: Double,
         circlePegs: List<CirclePegData>,
         trianglePegs: List<TrianglePegData>) {
        self.id = id
        self.name = name
        self.width = width
        self.height = height
        self.circlePegs = circlePegs
        self.trianglePegs = trianglePegs
        super.init()
    }

    /// Constructs a new `LevelData`.
    /// - Parameter level: A `Level` abstract data structure.
    convenience init(level: Level) {
        let circlePegDatas = level.pegs.compactMap { $0 as? CirclePeg }
            .map { CirclePegData(peg: $0) }
        let trianglePegDatas = level.pegs.compactMap { $0 as? TrianglePeg }
            .map { TrianglePegData(peg: $0) }
        let circlePegs = List<CirclePegData>()
        let trianglePegs = List<TrianglePegData>()
        circlePegs.append(objectsIn: circlePegDatas)
        trianglePegs.append(objectsIn: trianglePegDatas)
        self.init(id: level.id,
                  name: level.name,
                  width: Double(level.size.width),
                  height: Double(level.size.height),
                  circlePegs: circlePegs,
                  trianglePegs: trianglePegs)
    }
}
