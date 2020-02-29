//
//  AmmoLabel.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class AmmoLabel: UILabel {
    init() {
        super.init(frame: .zero)
        textColor = .gray
        font = font.withSize(24)
        translatesAutoresizingMaskIntoConstraints = false
        text = "Shots left: \(Settings.Cannon.ammo)"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
