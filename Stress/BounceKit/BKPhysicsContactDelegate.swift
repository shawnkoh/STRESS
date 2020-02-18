//
//  BKPhysicsContactDelegate.swift
//  Bounce
//
//  Created by Shawn Koh on 11/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

protocol BKPhysicsContactDelegate: AnyObject {
    /**
     Called when the contact begins between two physical bodies.
     - Parameters:
        - contact: An object that describes the contact.
     */
    func didBegin(_ contact: BKPhysicsContact)
    /**
    Called when the contact ends between two physical bodies.
    - Parameters:
       - contact: An object that describes the contact.
    */
    func didEnd(_ contact: BKPhysicsContact)
}

// Make the protocol's methods optional
extension BKPhysicsContactDelegate {
    func didBegin(_ contact: BKPhysicsContact) {}
    func didEnd(_ contact: BKPhysicsContact) {}
}
