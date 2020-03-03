//
//  GalleryViewController.swift
//  Stress
//
//  Created by Shawn Koh on 2/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    unowned let store: Store
    unowned let stateMachine: GameStateMachine

    init(store: Store, stateMachine: GameStateMachine) {
        self.store = store
        self.stateMachine = stateMachine
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let background = Background()
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

            let playButton = LevelButton(levelData: levelData, hStack: hStack)
            playButton.setTitle("play", for: .normal)
            playButton.setTitleColor(.black, for: .normal)
            playButton.backgroundColor = .white
            playButton.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)
            hStack.addArrangedSubview(playButton)

            let editButton = LevelButton(levelData: levelData, hStack: hStack)
            editButton.setTitle("edit", for: .normal)
            editButton.setTitleColor(.black, for: .normal)
            editButton.backgroundColor = .white
            editButton.addTarget(self, action: #selector(edit(_:)), for: .touchUpInside)
            hStack.addArrangedSubview(editButton)

            let deleteButton = LevelButton(levelData: levelData, hStack: hStack)
            deleteButton.setTitle("delete", for: .normal)
            deleteButton.setTitleColor(.black, for: .normal)
            deleteButton.backgroundColor = .white
            deleteButton.addTarget(self, action: #selector(deleteLevel(_:)), for: .touchUpInside)
            hStack.addArrangedSubview(deleteButton)
        }
    }

    @objc private func back(_ sender: UIButton) {
        stateMachine.enter(TitleScreenState.self)
    }

    @objc private func play(_ sender: LevelButton) {
        stateMachine.state(forClass: SelectingLevelState.self)?.selectedLevelData = sender.levelData
        stateMachine.enter(PlayingState.self)
    }

    @objc private func edit(_ sender: LevelButton) {
        stateMachine.state(forClass: SelectingLevelState.self)?.selectedLevelData = sender.levelData
        stateMachine.enter(DesigningState.self)
    }

    @objc private func deleteLevel(_ sender: LevelButton) {
        do {
            try store.removeLevelData(sender.levelData)
        } catch let error {
            // TODO: Add dialog
        }
        sender.hStack.removeFromSuperview()
    }
}

private class LevelButton: UIButton {
    let levelData: LevelData
    let hStack: UIStackView

    init(levelData: LevelData, hStack: UIStackView) {
        self.levelData = levelData
        self.hStack = hStack
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
