//
//  Level.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/**
 `Level` is an abstract data structure that represents a game level in Stress.
 */
class Level: Identifiable {
    // MARK: Properties
    let id: String = UUID().uuidString
    var name: String
    var size: CGSize
    var pegs: Set<Peg>
    weak var delegate: LevelDelegate?

    init(name: String, size: CGSize, pegs: Set<Peg> = [], delegate: LevelDelegate? = nil) {
        self.name = name
        self.size = size
        self.pegs = pegs
        self.delegate = delegate
    }

    /// Adds a `Peg` into the level.
    /// - Parameter peg: The peg to be added.
    /// - Returns: True if the peg was succesfully added, or false otherwise.
    @discardableResult
    func addPeg(_ peg: Peg) -> Bool {
        pegs.insert(peg)
        return true
    }

    /**
     Removes the given peg from the level.
     - Parameter peg: The peg to be removed
     - Returns: The peg that was removed, or nil if it did not exist in the level.
     */
    @discardableResult
    func removePeg(_ peg: Peg) -> Peg? {
        guard let index = pegs.firstIndex(of: peg) else {
            return nil
        }
        return pegs.remove(at: index)
    }

    func removeAllPegs() {
        pegs = Set()
        delegate?.didRemoveAllPegs()
    }
}
