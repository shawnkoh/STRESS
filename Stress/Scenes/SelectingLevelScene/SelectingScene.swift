//
//  SelectingScene.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class SelectingScene: GKScene {
    unowned let stress: Stress
    let background = Background()

    init(stress: Stress) {
        self.stress = stress
        super.init()
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)

        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 32
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])

        for levelData in stress.store.levelDatas {
            let hStack = UIStackView(frame: .zero)
            hStack.axis = .horizontal
            hStack.alignment = .center
            hStack.distribution = .equalSpacing
            hStack.spacing = 16
            stackView.addArrangedSubview(hStack)

            let nameLabel = UILabel(frame: .zero)
            nameLabel.text = levelData.name
            nameLabel.backgroundColor = .white
            hStack.addArrangedSubview(nameLabel)

            let playButton = UIButton(frame: .zero)
            playButton.setTitle("play", for: .normal)
            playButton.setTitleColor(.black, for: .normal)
            playButton.backgroundColor = .white
            let playGesture = LevelTapGestureRecognizer(levelData: levelData,
                                                        hStack: hStack,
                                                        target: self,
                                                        action: #selector(tapPlay(_:)))
            playButton.addGestureRecognizer(playGesture)
            hStack.addArrangedSubview(playButton)

            let editButton = UIButton(frame: .zero)
            editButton.setTitle("edit", for: .normal)
            editButton.setTitleColor(.black, for: .normal)
            editButton.backgroundColor = .white
            let editGesture = LevelTapGestureRecognizer(levelData: levelData,
                                                        hStack: hStack,
                                                        target: self,
                                                        action: #selector(tapEdit(_:)))
            editButton.addGestureRecognizer(editGesture)
            hStack.addArrangedSubview(editButton)

            let deleteButton = UIButton(frame: .zero)
            deleteButton.setTitle("delete", for: .normal)
            deleteButton.setTitleColor(.black, for: .normal)
            deleteButton.backgroundColor = .white
            let deleteGesture = LevelTapGestureRecognizer(levelData: levelData,
                                                          hStack: hStack,
                                                          target: self,
                                                          action: #selector(tapDelete(_:)))
            deleteButton.addGestureRecognizer(deleteGesture)
            hStack.addArrangedSubview(deleteButton)
        }
    }

    @objc func tapBack() {
        stress.sceneStateMachine.enter(TitleScreenState.self)
    }

    @objc private func tapPlay(_ sender: LevelTapGestureRecognizer) {
        stress.sceneStateMachine.state(forClass: SelectingLevelState.self)?.selectedLevelData = sender.levelData
        stress.sceneStateMachine.enter(PlayingState.self)
    }

    @objc private func tapEdit(_ sender: LevelTapGestureRecognizer) {
        stress.sceneStateMachine.state(forClass: SelectingLevelState.self)?.selectedLevelData = sender.levelData
        stress.sceneStateMachine.enter(DesigningState.self)
    }

    @objc private func tapDelete(_ sender: LevelTapGestureRecognizer) {
        do {
            try stress.store.removeLevelData(sender.levelData)
        } catch let error {
            // TODO: Add dialog
        }
        sender.hStack.removeFromSuperview()
    }
}

private class LevelTapGestureRecognizer: UITapGestureRecognizer {
    let levelData: LevelData
    let hStack: UIStackView

    init(levelData: LevelData, hStack: UIStackView, target: Any?, action: Selector?) {
        self.levelData = levelData
        self.hStack = hStack
        super.init(target: target, action: action)
    }
}
