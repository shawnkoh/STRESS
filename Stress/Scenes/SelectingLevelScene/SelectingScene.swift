//
//  SelectingScene.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class SelectingScene: GKScene {
    unowned let store: Store
    let background = Background()
    let backAction: () -> Void
    let playAction: (LevelData) -> Void
    let editAction: (LevelData) -> Void

    init(store: Store,
         backAction: @escaping () -> Void,
         playAction: @escaping (LevelData) -> Void,
         editAction: @escaping (LevelData) -> Void) {
        self.store = store
        self.backAction = backAction
        self.playAction = playAction
        self.editAction = editAction
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

        for levelData in store.levelDatas {
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
        backAction()
    }

    @objc private func tapPlay(_ sender: LevelTapGestureRecognizer) {
        playAction(sender.levelData)
    }

    @objc private func tapEdit(_ sender: LevelTapGestureRecognizer) {
        editAction(sender.levelData)
    }

    @objc private func tapDelete(_ sender: LevelTapGestureRecognizer) {
        do {
            try store.removeLevelData(sender.levelData)
        } catch {
            fatalError("An error occured while saving data")
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
