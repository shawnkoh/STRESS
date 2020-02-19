//
//  GKState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

/// The protocol for defining state-specific logic as part of a state machine.
protocol GKState: AnyObject {
    // TODO: This should ideally only be gettable, not settable.
    /// The state machine that owns this state object.
    var stateMachine: GKStateMachine? { get set }

    /// Returns a Boolean value indicating whether a state machine currently in this
    /// state is allowed to transition into the specified state.
    /// - Parameter stateClass: A custom GKState class used in the same state machine as this state.
    /// - Returns: true if a transition into the specified state should be allowed; otherwise, false.
    func isValidNextState(_ stateClass: GKState.Type) -> Bool

    /// Performs custom actions when a state machine transitions into this state.
    /// - Parameter previousState: The state the state machine transitioned fromto enter
    /// this state. If the current state is the initial state of the state machine, this parameter’s value is nil.
    func didEnter(from previousState: GKState?)

    /// Performs custom actions when a state machine updates while in this state.
    /// - Parameter seconds: The time step to use for any time-dependent actions performed
    /// by this method (typically, the elapsed time since the previous call to this method).
    func update(deltaTime seconds: TimeInterval)

    /// Performs custom actions when a state machine transitions out of this state.
    /// - Parameter nextState: The state the state machine will transition into to exit this state.
    func willExit(to nextState: GKState)
}
