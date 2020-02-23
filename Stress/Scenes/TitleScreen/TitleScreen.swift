//
//  TitleScreenScene.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class TitleScreen: GKScene {
    unowned let stress: Stress
    let background = Background()
    let title = UILabel(frame: .zero)
    let play = UIButton(frame: .zero)
    let designer = UIButton(frame: .zero)

    init(stress: Stress) {
        self.stress = stress
        super.init()

        title.text = "STRESS"
        title.textAlignment = .center
        title.font = title.font.withSize(80)
        title.backgroundColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.widthAnchor.constraint(equalToConstant: 400),
            title.heightAnchor.constraint(equalToConstant: 100)
        ])

        play.setTitle("PLAY", for: .normal)
        play.setTitleColor(.black, for: .normal)
        play.titleLabel?.font = play.titleLabel?.font.withSize(50)
        play.backgroundColor = .white
        play.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            play.widthAnchor.constraint(equalToConstant: 400),
            play.heightAnchor.constraint(equalToConstant: 100)
        ])
        let playGesture = UITapGestureRecognizer(target: self, action: #selector(clickPlay))
        play.addGestureRecognizer(playGesture)

        designer.backgroundColor = .white
        designer.setTitle("CREATE LEVEL", for: .normal)
        designer.setTitleColor(.black, for: .normal)
        designer.titleLabel?.font = designer.titleLabel?.font.withSize(50)
        designer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            designer.widthAnchor.constraint(equalToConstant: 400),
            designer.heightAnchor.constraint(equalToConstant: 100)
        ])
        let designerGesture = UITapGestureRecognizer(target: self, action: #selector(clickDesigner))
        designer.addGestureRecognizer(designerGesture)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        view.addSubview(title)
        view.addSubview(play)
        view.addSubview(designer)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            play.centerXAnchor.constraint(equalTo: title.centerXAnchor),
            play.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            designer.centerXAnchor.constraint(equalTo: play.centerXAnchor),
            designer.topAnchor.constraint(equalTo: play.bottomAnchor, constant: 32)
        ])
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }

    @objc func clickPlay() {
        stress.sceneStateMachine.enter(SelectingLevelState.self)
    }

    @objc func clickDesigner() {
        stress.sceneStateMachine.enter(DesigningState.self)
    }
}
