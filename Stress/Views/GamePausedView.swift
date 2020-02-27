//
//  GamePausedView.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// A `GamePausedView` represents the Pausedning view in Stress.
class GamePausedView: UIView {
    let titleLabel = UILabel(frame: .zero)
    let restartButton = Button(width: 140, title: "Restart Level")
    let quitButton = Button(width: 140, title: "Quit Level")

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 16

        titleLabel.text = "GAME PAUSED"
        titleLabel.font = titleLabel.font.withSize(32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(restartButton)
        addSubview(quitButton)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -16),

            restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            quitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            quitButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 16)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }

    override func didMoveToSuperview() {
        guard let superview = superview else {
            return
        }

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.4),
            heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.4)
        ])
    }
}
