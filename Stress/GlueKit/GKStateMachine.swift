//
//  GKStateMachine.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// A finite-state machine—a collection of state objects that each define logic for a
/// particular state of gameplay and rules for transitioning between states.
class GKStateMachine {
    var states: [GKState]
    /// The state machine’s current state.
    private(set) var currentState: GKState?
    /// Initializes a state machine with the specified states.
    init(states: [GKState]) {
        self.states = states
        for state in states {
            state.stateMachine = self
        }
//        states.forEach { state in
//
//        }
    }

    func state<StateType>(forClass stateClass: StateType.Type) -> StateType? where StateType: GKState {
        states.first(where: { $0 is StateType }) as? StateType
    }

    /// Returns a Boolean value indicating whether it is valid for the state machine to
    /// transition from its current state to a state of the specified class.
    /// - Parameter stateClass: The class of state for which to determine whether a transition is allowed.
    /// - Returns: true if a transition is allowed from the current state to a
    /// state of the specified class; otherwise false.
    func canEnterState(_ stateClass: GKState.Type) -> Bool {
        currentState?.isValidNextState(stateClass) ?? true
    }

    /// Attempts to transition the state machine from its current state to a state of the specified class.
    /// - Parameter stateClass: The class of state into which to attempt a transition.
    /// - Returns: true if the transition was successful; otherwise false.
    @discardableResult
    func enter<StateType>(_ stateClass: StateType.Type) -> Bool where StateType: GKState {
        guard
            canEnterState(stateClass.self),
            let nextState = state(forClass: stateClass)
        else {
            return false
        }
        currentState?.willExit(to: nextState)
        currentState = nextState
        nextState.didEnter(from: currentState)
        return true
    }

    /// Tells the current state object to perform per-frame updates.
    /// - Parameter seconds: The time step to use for any time-dependent actions performed by this method
    /// (typically, the elapsed time since the previous call to this method).
    func update(deltaTime seconds: TimeInterval) {
        currentState?.update(deltaTime: seconds)
    }
}
