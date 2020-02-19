//
//  LevelDesigner.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// The `LevelDesigner` represents the state of Peggle's level designer.
class LevelDesigner {
    var size: CGSize
    var level: Level?
    var levelData: LevelData?

    init(size: CGSize) {
        self.size = size
    }

    /// Saves the current level, if it exists. Otherwise, do nothing.
    func saveLevelData() throws {
        guard let level = level else {
            return
        }

        if let levelData = self.levelData {
            self.levelData = try Store.updateLevelData(levelData, level: level)
        } else {
            let levelData = LevelData(level: level)
            self.levelData = try Store.saveLevelData(levelData)
        }
    }

    /// Sets up the LevelDesigner and binds the level to a delegate.
    /// - Parameter levelDelegate: The delegate to bind.
    func setup(levelDelegate: LevelDelegate) {
        if let levelData = levelData {
            loadLevelData(levelData, levelDelegate: levelDelegate)
        } else {
            loadEmptyLevel(levelDelegate: levelDelegate)
        }
    }

    /// Loads an empty level and binds the level to the delegate.
    /// - Parameter levelDelegate: The delegate to bind.
    func loadEmptyLevel(levelDelegate: LevelDelegate?) {
        level = Level(name: StressSettings.defaultLevelName, size: size, delegate: levelDelegate)
        levelData = nil
    }

    /// Loads the levelData into the LevelDesigner, and binds the delegate to the level.
    /// - Parameters:
    ///     - levelData: The level data to load.
    ///     - levelDelegate: The delegate to bind to the level.
    func loadLevelData(_ levelData: LevelData, levelDelegate: LevelDelegate?) {
        self.levelData = levelData
        self.level = constructLevel(from: levelData, delegate: levelDelegate)
    }

    /**
     Checks whether the peg can be added to the level.
     - Parameter peg: The peg to be added.
     - Returns: True if it can be, or false otherwise.
     */
    @discardableResult
    func addPeg(_ peg: Peg) -> Bool {
        level?.addPeg(peg) ?? false
    }

    /**
     Removes the given peg from the level.
     - Parameter peg: The peg to be removed
     - Returns: The peg that was removed, or nil if it did not exist in the level.
     */
    @discardableResult
    func removePeg(_ peg: Peg) -> Peg? {
        level?.removePeg(peg)
    }

    /**
     Removes all pegs from the current level.
     If there is no current level, do nothing.
     */
    func removeAllPegs() {
        level?.removeAllPegs()
    }

    // MARK: Private methods

    /// Constructs a `Level` from a `LevelData`.
    /// - Parameters:
    ///     - levelData: The `LevelData` to construct from.
    ///     - delegate: The delegate to bind to the `Level`.
    /// - Returns:The constructed `Level`
    private func constructLevel(from levelData: LevelData, delegate: LevelDelegate?) -> Level {
        let pegDatas = levelData.pegs.map { self.constructPeg(from: $0) }
        let level = Level(name: levelData.name,
                          size: CGSize(width: levelData.width, height: levelData.height),
                          pegs: Set(pegDatas),
                          delegate: delegate)
        return level
    }

    /// Constructs a `Peg` from a `PegData`.
    /// - Parameter pegData: The `PegData` to construct from.
    /// - Returns: The constructed `Peg`.
    private func constructPeg(from pegData: PegData) -> Peg {
        guard let type = PegType(rawValue: pegData.type) else {
            // TODO DONT USE FATAL ERROR
            fatalError("An invalid PegType was provided.")
        }

        let peg = Peg(center: CGPoint(x: pegData.centerX, y: pegData.centerY),
                      type: type,
                      radius: CGFloat(pegData.radius))
        return peg
    }
}
