//
//  BKPhysicsBodyDelegate.swift
//  Bounce
//
//  Created by Shawn Koh on 13/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

protocol BKPhysicsBodyDelegate: AnyObject {
    func didAppear(body: BKPhysicsBody)
    func didUpdate(body: BKPhysicsBody)
    func didRemove(body: BKPhysicsBody)
}

// Make the protocols methods optional without using @objc
// https://www.hackingwithswift.com/example-code/language/how-to-make-optional-protocol-methods
extension BKPhysicsBodyDelegate {
    func didAppear(body: BKPhysicsBody) {}
    func didUpdate(body: BKPhysicsBody) {}
    func didRemove(body: BKPhysicsBody) {}
}
