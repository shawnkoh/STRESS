//
//  PegComponent.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PegComponent: GKComponent {
    var type: PegType

    init(type: PegType) {
        self.type = type
    }
}

/**
The `PegType` enumeration represents the various types of pegs in Stress.
*/
enum PegType: Int {
    case blue
    /// An `orange` peg has to be eliminated in order to complete the level.
    case orange
    /// A `green` peg provides a `Space Blast` powerup when it is hit.
    case green
    /// A red peg provides a `Spooky Ball` powerup when it is hit.
    case red
}

/**
 The `PegShape` enumeration represents the various shapes of pegs in Stress.
 */
enum PegShape: Int {
    case circle
    case triangle
}
