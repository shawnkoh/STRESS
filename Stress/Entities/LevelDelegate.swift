//
//  LevelDelegate.swift
//  Stress
//
//  Created by Shawn Koh on 23/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

protocol LevelDelegate: AnyObject {
    func didAddPeg(_ peg: Peg)
    func didRemovePeg(_ peg: Peg)
}
