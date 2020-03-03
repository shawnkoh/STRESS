//
//  DesignerViewController.swift
//  Stress
//
//  Created by Shawn Koh on 2/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class DesignerViewController: UIViewController {
    unowned let store: Store
    unowned let stateMachine: GameStateMachine
    let levelData: LevelData

    init(store: Store, stateMachine: GameStateMachine, levelData: LevelData) {
        self.store = store
        self.stateMachine = stateMachine
        self.levelData = levelData
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = GKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = view as? GKView else {
            fatalError("Root view is not of type GKView")
        }
        view.presentScene(DesigningScene(store: store,
                                         levelData: levelData,
                                         backAction: { self.stateMachine.enter(TitleScreenState.self) }))
    }
}
