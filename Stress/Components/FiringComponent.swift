//
//  FiringComponent.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class FiringComponent: GKComponent {
    var projectileConstructor: () -> GKEntity

    init(projectileConstructor: @escaping () -> GKEntity) {
        self.projectileConstructor = projectileConstructor
        super.init()
    }
}
