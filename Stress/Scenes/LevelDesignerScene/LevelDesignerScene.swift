//
//  LevelDesignerScene.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class LevelDesignerScene: GKScene {
    unowned let stress: Stress
    let levelDesigner: LevelDesigner
    let background = Background()
    let stage = Stage()
    let palette = Palette()
    let level: LevelScene

    init(stress: Stress, size: CGSize) {
        self.stress = stress
        levelDesigner = LevelDesigner(size: size)
        level = LevelScene(size: size)

        super.init(size: size)

        let stageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapStage(_:)))
        stage.addGestureRecognizer(stageGestureRecognizer)
        stage.presentScene(level)

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
        view.addSubview(palette)
        NSLayoutConstraint.activate([
            stage.bottomAnchor.constraint(equalTo: palette.topAnchor, constant: -16)
        ])
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }

    @objc func tapStage(_ sender: UITapGestureRecognizer) {
        guard let type = palette.currentToolType else {
            return
        }
        let location = sender.location(in: stage)
        if case .create(let type) = type {
            guard hasNoOverlappingPegs(at: location) else {
                return
            }
            let peg = Peg(center: location, type: type)
            let draggableComponent = DraggableComponent(canDragTo: { location in
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
                let pegs = self.level.entities(ofType: Peg.self)
                return pegs.filter { $0 != peg }
                           .compactMap { $0.component(ofType: VisualComponent.self)?.view }
                           .allSatisfy { location.distance(to: $0.center) >= $0.frame.width }
            })
            peg.addComponent(draggableComponent)
            peg.addComponent(DestroyableComponent())
            level.addEntity(peg)
        }
    }

    @objc func tapBack() {
        stress.sceneStateMachine.enter(TitleScreenState.self)
    }

    @objc func tapReset() {
        level.entities(ofType: Peg.self).forEach {
            level.removeEntity($0)
        }
    }

    @objc func tapLoad() {
    }

    @objc func tapSave() {
    }

    @objc func tapPlay() {
    }

    // MARK: Private methods

    private func hasNoOverlappingPegs(at location: CGPoint) -> Bool {
        level.entities(ofType: Peg.self)
            .compactMap { $0.component(ofType: VisualComponent.self)?.view }
            .allSatisfy { location.distance(to: $0.center) >= $0.bounds.width }
    }

    /// Constructs a `Level` from a `LevelData`.
    /// - Parameters:
    ///     - levelData: The `LevelData` to construct from.
    ///     - delegate: The delegate to bind to the `Level`.
    /// - Returns:The constructed `Level`
    private func constructLevel(from levelData: LevelData, delegate: LevelDelegate?) -> LevelScene {
        let pegs = levelData.pegs.map { self.constructPeg(from: $0) }
        let level = LevelScene(size: CGSize(width: levelData.width, height: levelData.height),
                               name: levelData.name)
        pegs.forEach { level.addEntity($0) }
        return level
    }

    /// Constructs a `Peg` from a `PegData`.
    /// - Parameter pegData: The `PegData` to construct from.
    /// - Returns: The constructed `Peg`.
    private func constructPeg(from pegData: PegData) -> Peg {
        guard let type = PegType(rawValue: pegData.type) else {
            // TODO: DONT USE FATAL ERROR
            fatalError("An invalid PegType was provided.")
        }

        let peg = Peg(center: CGPoint(x: pegData.centerX, y: pegData.centerY),
                      type: type,
                      radius: CGFloat(pegData.radius))
        return peg
    }
}
