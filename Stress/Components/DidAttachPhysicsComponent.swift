//
//  DidAttachPhysicsComponent.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// A system state component to indicate that the entity has been attached to a physics body.
/// See https://rams3s.github.io/blog/2019-01-09-ecs-deep-dive/#detecting-new-and-deleted-entities
/// and https://docs.unity3d.com/Packages/com.unity.entities@0.1/manual/system_state_components.html
class DidAttachPhysicsComponent: GKComponent {}
