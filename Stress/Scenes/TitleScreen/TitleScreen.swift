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
    let title: UILabel
    let play: UIButton
    let designer: UIButton

    init(stress: Stress, size: CGSize) {
        self.stress = stress
        let center = CGPoint(x: size.width / 2, y: size.height / 2)

        title = UILabel(frame: .zero)
        title.frame.size = CGSize(width: size.width - 400, height: 150)
        title.center = center - CGVector(dx: 0, dy: 200)
        title.text = "stress"
        title.textAlignment = .center
        title.font = title.font.withSize(80)
        title.backgroundColor = .white

        play = UIButton(frame: .zero)
        play.frame.size = CGSize(width: size.width - 400, height: 100)
        play.center = center
        play.backgroundColor = .white
        play.setTitle("play", for: .normal)
        play.setTitleColor(.black, for: .normal)
        play.titleLabel?.font = play.titleLabel?.font.withSize(50)

        designer = UIButton(frame: .zero)
        designer.frame.size = CGSize(width: size.width - 400, height: 100)
        designer.center = center + CGVector(dx: 0, dy: 150)
        designer.backgroundColor = .white
        designer.setTitle("level designer", for: .normal)
        designer.setTitleColor(.black, for: .normal)
        designer.titleLabel?.font = designer.titleLabel?.font.withSize(50)

        super.init(size: size)

        let playGesture = UITapGestureRecognizer(target: self, action: #selector(clickPlay))
        play.addGestureRecognizer(playGesture)

        let designerGesture = UITapGestureRecognizer(target: self, action: #selector(clickDesigner))
        designer.addGestureRecognizer(designerGesture)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        view.addSubview(title)
        view.addSubview(play)
        view.addSubview(designer)
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
    }

    @objc func clickPlay() {
        stress.sceneStateMachine.enter(PlayingState.self)
    }

    @objc func clickDesigner() {
        stress.sceneStateMachine.enter(DesigningState.self)
    }
}
