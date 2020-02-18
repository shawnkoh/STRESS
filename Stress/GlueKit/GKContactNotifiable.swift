//
//  ContactNotifiable.swift
//  Bounce
//
//  Created by Shawn Koh on 16/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

/**
 
 Credit: https://code.bitbebop.com/collision-notification-swift/
 */
protocol GKContactNotifiable: GKEntity {
    func contactDidBegin(with entity: GKEntity)
    func contactDidEnd(with entity: GKEntity)
}

// Make the methods optional
extension GKContactNotifiable {
    func contactDidBegin(with entity: GKEntity) {}
    func contactDidEnd(with entity: GKEntity) {}
}
