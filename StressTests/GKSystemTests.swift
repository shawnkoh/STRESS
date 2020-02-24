//
//  GKSystemTests.swift
//  GKSystemTests
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import XCTest
@testable import Stress

class GKSystemTests: XCTestCase {
    func testAddEntity() {
        let view = GKView()
        let scene = GKScene()
        view.presentScene(scene)
        let system = TransformSystem()
        scene.addSystem(system)
        let exit = Exit(from: .zero, to: .zero)
        scene.addEntity(exit)

        XCTAssertTrue(system.entities.isEmpty)
    }
}
