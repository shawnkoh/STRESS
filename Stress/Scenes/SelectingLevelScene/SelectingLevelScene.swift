//
//  SelectingLevelScene.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit
import RealmSwift

class SelectingLevelScene: GKScene {
    unowned let stress: Stress
    let background = Background()
    private var realm: Realm
    private var levels: Results<LevelData>

    init(stress: Stress, size: CGSize) {
        self.stress = stress
        do {
            realm = try Realm()
            levels = realm.objects(LevelData.self)
        } catch let error as NSError {
            // TODO: Don't use fatal error
            fatalError(error.localizedDescription)
        }
        super.init(size: size)
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

        for levelData in levels {
            let level = Store.constructLevel(from: levelData)
            let playButton = UIButton(frame: .zero)
            playButton.setTitle(levelData.name, for: .normal)
            playButton.setTitleColor(.black, for: .normal)
            playButton.backgroundColor = .white
            let tapGesture = LevelTapGestureRecognizer(level: level, target: self, action: #selector(tapPlay(_:)))
            playButton.addGestureRecognizer(tapGesture)
            stackView.addArrangedSubview(playButton)
        }
    }
//        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
//                .forEach { view.addSubview($0) }

    @objc func tapBack() {
        stress.sceneStateMachine.enter(TitleScreenState.self)
    }

    @objc func tapPlay(_ sender: LevelTapGestureRecognizer) {
        stress.sceneStateMachine.state(forClass: SelectingLevelState.self)?.selectedLevel = sender.level
        stress.sceneStateMachine.enter(PlayingState.self)
    }
}

class LevelTapGestureRecognizer: UITapGestureRecognizer {
    let level: Level

    init(level: Level, target: Any?, action: Selector?) {
        self.level = level
        super.init(target: target, action: action)
    }
}
