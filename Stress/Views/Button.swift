//
//  Button.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Button: UIButton {
    init(width: CGFloat, title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .gray
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: 2 / 7)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
