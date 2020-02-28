//
//  GKComponent.swift
//  Bounce
//
//  Created by Shawn Koh on 14/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// The abstract superclass for creating objects that add specific gameplay functionality to an entity.
class GKComponent: Identifiable {
    let id = UUID().uuidString
    func didAddToEntity(_ entity: GKEntity) {}
}

extension GKComponent: Equatable {
    static func == (lhs: GKComponent, rhs: GKComponent) -> Bool {
        lhs.id == rhs.id
    }
}
