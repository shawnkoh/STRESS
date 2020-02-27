//
//  DesigningScene.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class DesigningScene: GKScene {
    unowned let store: Store
    unowned var levelData: LevelData

    let background = Background()
    var stage: Stage
    var levelScene = LevelScene()
    let nameLabel = LevelNameLabel()
    let palette = Palette()
    let backAction: () -> Void

    init(store: Store, levelData: LevelData, backAction: @escaping () -> Void) {
        self.store = store
        self.levelData = levelData
        self.backAction = backAction
        self.stage = Stage(size: CGSize(width: levelData.width, height: levelData.height))

        super.init()

        let stageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapStage(_:)))
        stage.addGestureRecognizer(stageGestureRecognizer)
        stage.presentScene(levelScene)

        palette.backControl.addTarget(self, action: #selector(tapBack), for: .touchDown)
        palette.resetControl.addTarget(self, action: #selector(tapReset), for: .touchDown)
        palette.loadControl.addTarget(self, action: #selector(tapLoad), for: .touchDown)
        palette.saveControl.addTarget(self, action: #selector(tapSave), for: .touchDown)
        palette.playControl.addTarget(self, action: #selector(tapPlay), for: .touchDown)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        view.addSubview(stage)
        view.addSubview(nameLabel)
        view.addSubview(palette)
        NSLayoutConstraint.activate([
            stage.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: palette.topAnchor, constant: -16)
        ])

        loadLevelData()
    }

    @objc func tapStage(_ sender: UITapGestureRecognizer) {
        guard let type = palette.currentToolType else {
            return
        }
        let location = sender.location(in: stage)
        if case .create(let type) = type {
            createPeg(at: location, shape: type.shape, isObjective: type.isObjective)
        }
    }

    @objc func tapBack() {
        backAction()
    }

    @objc func tapReset() {
        loadLevelData()
    }

    @objc func tapLoad() {
    }

    @objc func tapSave() {
        guard let levelName = nameLabel.text else {
            fatalError("Name label does not have a string")
        }
        do {
            let pegs = levelScene.entities(ofType: Peg.self)
            let level = Level(name: levelName, size: stage.size, pegs: Set(pegs), id: levelData.id)
            try store.saveLevel(level)
        } catch let error as NSError {
            // TODO: dont use fatal error
            fatalError(error.localizedDescription)
        }
    }

    @objc func tapPlay() {
    }

    // MARK: Private methods

    private func addInteractableComponents(to peg: Peg) {
        let panGesture = UIPanGestureRecognizer()
        let panAction: (UIGestureRecognizer) -> Void = { sender in
            guard let transformComponent = peg.component(ofType: TransformComponent.self) else {
                fatalError("Unable to access transform component")
            }
            let location = sender.location(in: self.stage)
            if self.canPlace(peg: peg, at: location) {
                transformComponent.position = location
            }
        }
        let panComponent = InteractableComponent(gestureRecognizer: panGesture, action: panAction)
        peg.addComponent(panComponent)

        let longPressGesture = UILongPressGestureRecognizer()
        let longPressAction: (UIGestureRecognizer) -> Void = { sender in
            if sender.state == .ended {
                peg.addComponent(WillDestroyComponent())
            }
        }
        let longPressComponent = InteractableComponent(gestureRecognizer: longPressGesture, action: longPressAction)
        peg.addComponent(longPressComponent)

        let tapGesture = UITapGestureRecognizer()
        let tapAction: (UIGestureRecognizer) -> Void = { sender in
            if case .delete = self.palette.currentToolType {
                peg.addComponent(WillDestroyComponent())
            }
        }
        let tapComponent = InteractableComponent(gestureRecognizer: tapGesture, action: tapAction)
        peg.addComponent(tapComponent)
    }

    private func loadLevelData() {
        nameLabel.text = levelData.name

        levelScene.entities.forEach {
            $0.addComponent(WillDestroyComponent())
        }
        let level = Store.constructLevel(from: levelData)
        level.pegs.forEach { peg in
            addInteractableComponents(to: peg)
            levelScene.addEntity(peg)
        }
    }

    private func hasNoOverlappingPegs(at location: CGPoint, ignore peg: Peg) -> Bool {
        levelScene.entities(ofType: Peg.self)
            .filter { $0 != peg }
            .compactMap { $0.component(ofType: VisualComponent.self)?.view }
            .allSatisfy { location.distance(to: $0.center) >= $0.bounds.width }
    }

    private func canPlace(peg: Peg, at location: CGPoint) -> Bool {
        guard let view = peg.component(ofType: VisualComponent.self)?.view else {
            fatalError("Unable to access the Peg's visual component.")
        }
        let radius = view.frame.width / 2
        guard location.x >= radius &&
            location.x <= self.stage.frame.width - radius &&
            location.y >= radius &&
            location.y <= self.stage.frame.height - radius else {
            return false
        }
        return self.hasNoOverlappingPegs(at: location, ignore: peg)
    }

    private func createPeg(at location: CGPoint, shape: PegShape, isObjective: Bool) {
        let peg = Peg(center: location, shape: shape, isObjective: isObjective)
        guard canPlace(peg: peg, at: location) else {
            return
        }
        addInteractableComponents(to: peg)
        levelScene.addEntity(peg)
    }
}
