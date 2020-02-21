//
//  Background.swift
//  Stress
//
//  Created by Shawn Koh on 21/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Background: UIImageView {
    init() {
        super.init(frame: .zero)
        image = StressSettings.defaultBackgroundImage
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func didMoveToSuperview() {
        superview?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        superview?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        superview?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        superview?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
