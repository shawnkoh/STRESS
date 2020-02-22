//
//  Savable.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import RealmSwift

protocol Savable where Self: GKEntity {
    func save() -> Object
}
