//
//  SceneState.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

protocol SceneState where Self: GKState {
    var sceneStateMachine: SceneStateMachine { get }
    var presenter: GKView { get }
}

extension SceneState {
    var sceneStateMachine: SceneStateMachine {
        guard let sceneStateMachine = stateMachine as? SceneStateMachine else {
            fatalError("PlayingState must be bounded to a SceneStateMachine")
        }
        return sceneStateMachine
    }
    var presenter: GKView {
        sceneStateMachine.presenter
    }
}
