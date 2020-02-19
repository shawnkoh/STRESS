//
//  LevelDelegate.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

/**
 Provides the ability to act as the delegate for a `Level`.
 */
protocol LevelDelegate: AnyObject {
    /// Called when a new peg has been added.
    func didAddPeg(_ peg: Peg)

    /// Called when a peg has been replaced.
    func didReplacePeg(oldPeg: Peg, newPeg: Peg)

    /// Called when a peg has been removed.
    func didRemovePeg(_ peg: Peg)

    /// Called only when all the pegs in the level have been told to be removed.
    /// This will not trigger when the last peg in a level has been removed by `level.removePeg(_:)`
    func didRemoveAllPegs()

    /// Called when the level's name has been changed.
    func didNameChange(_ name: String)
}
