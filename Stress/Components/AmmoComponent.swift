//
//  AmmoComponent.swift
//  Stress
//
//  Created by Shawn Koh on 28/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// This component keeps track of how many shots an entity has left.
class AmmoComponent: GKComponent {
    var ammo: Int

    init(ammo: Int) {
        self.ammo = ammo
    }
}
