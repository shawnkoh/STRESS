//
//  SceneDelegate.swift
//  Bounce
//
//  Created by Shawn Koh on 13/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

protocol GKSceneDelegate: AnyObject {
    func update(for: GKScene)
    func didSimulatePhysics(for: GKScene)
    func didFinishUpdate(for: GKScene)
}

// Make the protocol's methods optional
extension GKSceneDelegate {
    func update(for: GKScene) {}
    func didSimulatePhysics(for: GKScene) {}
    func didFinishUpdate(for: GKScene) {}
}
