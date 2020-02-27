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
    let resumeButton = Button(width: 140, title: "Resume Level")
    let restartButton = Button(width: 140, title: "Restart Level")
    let quitButton = Button(width: 140, title: "Quit Level")
    let resumeAction: () -> Void
    let restartAction: () -> Void
    let quitAction: () -> Void

    init(resumeAction: @escaping () -> Void, restartAction: @escaping () -> Void, quitAction: @escaping () -> Void) {
        self.resumeAction = resumeAction
        self.restartAction = restartAction
        self.quitAction = quitAction
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 16

        titleLabel.text = "GAME PAUSED"
        titleLabel.font = titleLabel.font.withSize(32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(resumeButton)
        addSubview(restartButton)
        addSubview(quitButton)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: resumeButton.topAnchor, constant: -16),

            resumeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resumeButton.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -16),

            restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 16),

            quitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            quitButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 16)
        ])

        resumeButton.addTarget(self, action: #selector(resume(_:)), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restart(_:)), for: .touchUpInside)
        quitButton.addTarget(self, action: #selector(quit(_:)), for: .touchUpInside)
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

    @objc func resume(_ sender: Button) {
        resumeAction()
    }

    @objc func restart(_ sender: Button) {
        restartAction()
    }

    @objc func quit(_ sender: Button) {
        quitAction()
    }
}
