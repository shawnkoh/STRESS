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
    static let shared = Store().realm
    private var realm: Realm

    /// Initialises an instance of `Store`.
    /// This is restricted because `Store` is a singleton.
    /// You may access the `Store`'s static functions and variables directly.
    private init() {
        do {
            realm = try Realm()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    /// An auto-updating list of `LevelData`s.
    static var levelDatas: Results<LevelData> {
        shared.objects(LevelData.self)
    }

    /// Saves a `LevelData` into the store.
    /// - Parameter _: The level data to be saved.
    @discardableResult
    static func saveLevelData(_ levelData: LevelData) throws -> LevelData {
        try shared.write {
            shared.add(levelData)
        }
        return levelData
    }

    /// Removes a `LevelData` from the store.
    /// - Parameter _: The level data to be removed.
    static func removeLevelData(_ levelData: LevelData) throws {
        try shared.write {
            shared.delete(levelData)
        }
    }

    /// Updates the level data stored in Realm with the given level,
    /// or stores a new level data if it is invalidated.
    /// - Parameters:
    ///     - levelData: The level data to update.
    ///     - level: The level to update the data with.
    /// - Returns: The level data that was updated, or a new level data if it was invalidated.
    static func updateLevelData(_ levelData: LevelData, level: Level) throws -> LevelData {
        guard !levelData.isInvalidated else {
            return try saveLevelData(levelData)
        }

        try shared.write {
            levelData.name = level.name
            levelData.pegs.removeAll()
            let pegDatas = level.pegs.map { PegData(peg: $0) }
            levelData.pegs.append(objectsIn: pegDatas)
        }
        return levelData
    }
}
