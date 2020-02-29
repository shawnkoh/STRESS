//
//  MenuButton.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class MenuButton: UIImageView {
    let action: () -> Void
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(image: UIImage(systemName: "pause.circle"))

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 48),
            heightAnchor.constraint(equalToConstant: 48)
        ])

        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(gesture)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    @objc private func tap() {
        action()
    }
}
