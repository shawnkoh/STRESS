//
//  ScoreLabel.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class ScoreLabel: UILabel {
    init() {
        super.init(frame: .zero)
        textColor = .blue
        font = font.withSize(48)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
