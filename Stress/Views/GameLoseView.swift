//
//  GameLoseScene.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// A `GameLoseView` represents the losing view in Stress.
class GameLoseView: UIView {
    let titleLabel = UILabel(frame: .zero)
    let scoreLabel = UILabel(frame: .zero)
    let replayButton = Button(width: 140, title: "REPLAY")
    let replayAction: () -> Void

    init(score: Int, replayAction: @escaping () -> Void) {
        self.replayAction = replayAction
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        titleLabel.text = "YOU LOSE!"
        titleLabel.font = titleLabel.font.withSize(32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        scoreLabel.text = String(score)
        scoreLabel.textColor = .blue
        scoreLabel.font = scoreLabel.font.withSize(48)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreLabel)

        replayButton.addTarget(self, action: #selector(replay(_:)), for: .touchUpInside)
        addSubview(replayButton)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),

            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            replayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            replayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
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
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.3),
            heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.3)
        ])
    }

    @objc func replay(_ sender: UITapGestureRecognizer) {
        replayAction()
    }
}
