//
//  TitleScreenScene.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class TitleScreen: GKScene {
    let background = Background()
    let title = UILabel(frame: .zero)
    let playButton = UIButton(frame: .zero)
    let designButton = UIButton(frame: .zero)
    let playAction: () -> Void
    let designAction: () -> Void

    init(playAction: @escaping () -> Void, designAction: @escaping () -> Void) {
        self.playAction = playAction
        self.designAction = designAction
        super.init()

        title.text = "STRESS"
        title.textAlignment = .center
        title.font = title.font.withSize(64)
        title.backgroundColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false

        playButton.setTitle("PLAY", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = playButton.titleLabel?.font.withSize(32)
        playButton.backgroundColor = .red
        playButton.layer.cornerRadius = 32
        playButton.translatesAutoresizingMaskIntoConstraints = false

        designButton.backgroundColor = .white
        designButton.setTitle("CREATE LEVEL", for: .normal)
        designButton.setTitleColor(.black, for: .normal)
        designButton.titleLabel?.font = designButton.titleLabel?.font.withSize(32)
        designButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.widthAnchor.constraint(equalToConstant: 300),
            title.heightAnchor.constraint(equalToConstant: 100),

            playButton.widthAnchor.constraint(equalToConstant: 300),
            playButton.heightAnchor.constraint(equalToConstant: 60),

            designButton.widthAnchor.constraint(equalToConstant: 300),
            designButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        designButton.addTarget(self, action: #selector(design), for: .touchUpInside)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        view.addSubview(title)
        view.addSubview(playButton)
        view.addSubview(designButton)

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: title.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            designButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            designButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 32)
        ])

        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }

    @objc func play() {
        playAction()
    }

    @objc func design() {
        designAction()
    }
}
