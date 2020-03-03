//
//  Store.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import RealmSwift

/// The `Store` represents the persisted state of Peggle.
class Store {
    /// The instance of the Realm database used to persist the state of Peggle.
    let realm: Realm

    init() {
        do {
            realm = try Realm()

            if levelDatas.isEmpty {
                preloadLevels()
            }
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
            levelData.circlePegs.forEach { print($0) }
            levelData.trianglePegs.forEach { print($0) }
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
        let circlePegs: [Peg] = levelData.circlePegs.map { self.constructCirclePeg(from: $0) }
        let trianglePegs: [Peg] = levelData.trianglePegs.map { self.constructTrianglePeg(from: $0) }
        let pegs = Set(circlePegs).union(trianglePegs)
        let level = Level(name: levelData.name,
                          size: CGSize(width: levelData.width, height: levelData.height),
                          pegs: pegs,
                          id: levelData.id)
        return level
    }

    /// Constructs a `Peg` from a `PegData`.
    /// - Parameter pegData: The `PegData` to construct from.
    /// - Returns: The constructed `Peg`.
    private static func constructCirclePeg(from data: CirclePegData) -> CirclePeg {
        guard let type = PegType(rawValue: data.type) else {
            // TODO: DONT USE FATAL ERROR
            fatalError("An invalid data was provided.")
        }

        return CirclePeg(center: CGPoint(x: data.centerX, y: data.centerY),
                         type: type,
                         radius: CGFloat(data.radius))
    }

    private static func constructTrianglePeg(from data: TrianglePegData) -> TrianglePeg {
        guard let type = PegType(rawValue: data.type) else {
            // TODO: DONT USE FATAL ERROR
            fatalError("An invalid PegType was provided.")
        }

        let vertexA = CGPoint(x: data.vertexAX, y: data.vertexAY)
        let vertexB = CGPoint(x: data.vertexBX, y: data.vertexBY)
        let vertexC = CGPoint(x: data.vertexCX, y: data.vertexCY)

        return TrianglePeg(vertexA: vertexA, vertexB: vertexB, vertexC: vertexC, type: type)
    }

    private static func constructLevelData(from level: Level) -> LevelData {
        let circlePegDatas = level.pegs
            .compactMap { ($0 as? CirclePeg)?.save() as? CirclePegData }
        let trianglePegDatas = level.pegs
            .compactMap { ($0 as? TrianglePeg)?.save() as? TrianglePegData }
        let circlePegs: List<CirclePegData> = List()
        let trianglePegs: List<TrianglePegData> = List()
        // TODO: Might be problematic because we need to do this in a realm
        circlePegs.append(objectsIn: circlePegDatas)
        trianglePegs.append(objectsIn: trianglePegDatas)
        let levelData = LevelData(name: level.name,
                                  width: Double(level.size.width),
                                  height: Double(level.size.height),
                                  circlePegs: circlePegs,
                                  trianglePegs: trianglePegs,
                                  id: level.id)
        return levelData
    }

    private func preloadLevels() {
        guard levelDatas.isEmpty else {
            return
        }
    }
}
