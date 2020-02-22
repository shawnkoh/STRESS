//
//  LevelNameLabel.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

protocol LevelNameLabelDelegate: AnyObject {
    func didEditName(newName: String)
}

class LevelNameLabel: UILabel {
    weak var delegate: LevelNameLabelDelegate?

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    init() {
        super.init(frame: .zero)
        font = font.withSize(32)
        translatesAutoresizingMaskIntoConstraints = false

        isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editName(_:)))
        addGestureRecognizer(gestureRecognizer)
    }

    @objc func editName(_ sender: UITapGestureRecognizer) {
        guard let viewController = self.window?.rootViewController else {
            fatalError("Unable to access view controller")
        }
        Dialogs.showPrompt(in: viewController,
                           title: "Level Name",
                           message: "Please enter a level name.",
                           confirmActionTitle: "Save",
                           placeholder: "Please enter a level name",
                           initialValue: text ?? "",
                           confirmHandler: { input in
                            self.text = input
                            self.delegate?.didEditName(newName: input)
                           }
        )
    }
}
