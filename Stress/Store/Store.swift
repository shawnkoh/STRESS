//
//  Store.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import RealmSwift

/// The `Store` represents the persisted state of Peggle.
struct Store {
    /// The instance of the Realm database used to persist the state of Peggle.
    let realm: Realm

    init() {
        do {
            realm = try Realm()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    /// An auto-updating list of `LevelData`s.
    var levelDatas: Results<LevelData> {
        realm.objects(LevelData.self)
    }

    /// Saves a `LevelData` into the store.
    /// - Parameter _: The level data to be saved.
    func saveLevel(_ level: Level) throws {
        try realm.write {
            let levelData = Store.constructLevelData(from: level)
            realm.add(levelData, update: .modified)
        }
    }

    func removeLevelData(_ levelData: LevelData) throws {
        try realm.write {
            realm.delete(levelData)
        }
    }

    /// Constructs a `Level` from a `LevelData`.
    /// - Parameters:
    ///     - levelData: The `LevelData` to construct from.
    ///     - delegate: The delegate to bind to the `Level`.
    /// - Returns:The constructed `Level`
    static func constructLevel(from levelData: LevelData) -> Level {
        let pegs = levelData.pegs.map { self.constructPeg(from: $0) }
        let level = Level(name: levelData.name,
                          size: CGSize(width: levelData.width, height: levelData.height),
                          pegs: Set(pegs),
                          id: levelData.id)
        return level
    }

    /// Constructs a `Peg` from a `PegData`.
    /// - Parameter pegData: The `PegData` to construct from.
    /// - Returns: The constructed `Peg`.
    static func constructPeg(from pegData: PegData) -> Peg {
        guard let shape = PegShape(rawValue: pegData.shape) else {
            // TODO: DONT USE FATAL ERROR
            fatalError("An invalid PegShape was provided.")
        }

        let peg = Peg(center: CGPoint(x: pegData.centerX, y: pegData.centerY),
                      shape: shape,
                      isObjective: pegData.isObjective,
                      radius: CGFloat(pegData.radius))
        return peg
    }

    static func constructLevelData(from level: Level) -> LevelData {
        let pegDatas = level.pegs.compactMap { $0.save() as? PegData }
        let pegs: List<PegData> = List()
        // TODO: Might be problematic because we need to do this in a realm
        pegs.append(objectsIn: pegDatas)
        let levelData = LevelData(id: level.id,
                                  name: level.name,
                                  width: Double(level.size.width),
                                  height: Double(level.size.height),
                                  pegs: pegs)
        return levelData
    }
}
