//
//  TrianglePegData.swift
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
class TrianglePegData: Object {
    override class func primaryKey() -> String? {
        "id"
    }

    // Realm has no auto-incrementing properties, so generate a unique string ID.
    // More info here: https://realm.io/docs/swift/latest#limitations-models
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var vertexAX = Double()
    @objc dynamic var vertexAY = Double()
    @objc dynamic var vertexBX = Double()
    @objc dynamic var vertexBY = Double()
    @objc dynamic var vertexCX = Double()
    @objc dynamic var vertexCY = Double()
    @objc dynamic var type: Int = 0

    /// Constructs an empty `PegData`.
    required init() {
        super.init()
    }

    /// Constructs a new `PegData`.
    /// - Parameters:
    ///     - vertexA: The x position of the peg's center.
    ///     - vertexB: The y position of the peg's center.
    ///     - vertexC: The y position of the peg's center.
    ///     - radius: The radius of the peg.
    ///     - type: An integer representing the peg's `PegShape`.
    convenience init(vertexAX: Double,
                     vertexAY: Double,
                     vertexBX: Double,
                     vertexBY: Double,
                     vertexCX: Double,
                     vertexCY: Double,
                     type: Int,
                     id: String = UUID().uuidString) {
        self.init()
        self.id = id
        self.vertexAX = vertexAX
        self.vertexAY = vertexAY
        self.vertexBX = vertexBX
        self.vertexBY = vertexBY
        self.vertexCX = vertexCX
        self.vertexCY = vertexCY
        self.type = type
    }

    /// Constructs a new `PegData`.
    /// - Parameter peg: A peg entity
    convenience init(peg: TrianglePeg) {
        guard
            let pegComponent = peg.component(ofType: PegComponent.self),
            let transformComponent = peg.component(ofType: TransformComponent.self),
            let view = peg.component(ofType: VisualComponent.self)?.view
        else {
            fatalError("The Peg does not have the required components")
        }

        let centroid = transformComponent.position
        let radius = view.frame.width / 2
        let vertexA = centroid + CGVector(dx: 0, dy: -radius)
        let vertexB = centroid + CGVector(dx: -radius, dy: radius)
        let vertexC = centroid + CGVector(dx: radius, dy: radius)

        self.init(vertexAX: Double(vertexA.x),
                  vertexAY: Double(vertexA.y),
                  vertexBX: Double(vertexB.x),
                  vertexBY: Double(vertexB.y),
                  vertexCX: Double(vertexC.x),
                  vertexCY: Double(vertexC.y),
                  type: pegComponent.type.rawValue,
                  id: peg.id)
    }
}
