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
        let root = UIStackView()
        view.addSubview(root)
        root.axis = .vertical
        root.distribution = .equalSpacing
        root.alignment = .center
        root.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            root.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            root.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            root.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            root.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
        // TODO: Make a better level selector
        levels.forEach { level in
            let label = UILabel(frame: .zero)
            label.text = level.name
            root.addArrangedSubview(label)
        }
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }

    @objc func tapBack() {
        stress.sceneStateMachine.enter(TitleScreenState.self)
    }

    @objc func tapLoad() {
    }

    @objc func tapPlay() {
    }
}
