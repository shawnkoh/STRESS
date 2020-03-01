//
//  CirclePegData.swift
//  Stress
//
//  Created by Shawn Koh on 2/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import RealmSwift

/**
 `PegData` represents a Realm model object for the abstract data structure `Peg`.
 It is intended to be used for persisting `Peg`s.
 */
class CirclePegData: Object {
    override class func primaryKey() -> String? {
        "id"
    }

    // Realm has no auto-incrementing properties, so generate a unique string ID.
    // More info here: https://realm.io/docs/swift/latest#limitations-models
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var centerX = Double()
    @objc dynamic var centerY = Double()
    @objc dynamic var radius = Double()
    @objc dynamic var type: Int = 0

    /// Constructs an empty `PegData`.
    required init() {
        super.init()
    }

    /// Constructs a new `PegData`.
    /// - Parameters:
    ///     - centerX: The x position of the peg's center.
    ///     - centerY: The y position of the peg's center.
    ///     - radius: The radius of the peg.
    ///     - type: An integer representing the peg's `PegType`.
    convenience init(id: String, centerX: Double, centerY: Double, radius: Double, type: Int) {
        self.init()
        self.id = id
        self.centerX = centerX
        self.centerY = centerY
        self.radius = radius
        self.type = type
    }

    /// Constructs a new `PegData`.
    /// - Parameter peg: A peg entity
    convenience init(peg: CirclePeg) {
        guard
            let pegComponent = peg.component(ofType: PegComponent.self),
            let transformComponent = peg.component(ofType: TransformComponent.self),
            let view = peg.component(ofType: VisualComponent.self)?.view
        else {
            fatalError("The Peg does not have the required components")
        }

        self.init(id: peg.id,
                  centerX: Double(transformComponent.position.x),
                  centerY: Double(transformComponent.position.y),
                  radius: Double(view.bounds.size.width / 2),
                  type: pegComponent.type.rawValue)
    }
}
