//
//  GameWinView.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// A `GameWinView` represents the winning view in Stress.
class GameWinView: UIView {
    let label = UILabel(frame: .zero)

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        label.text = "YOU WIN!"
        addSubview(label)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }

    override func didMoveToSuperview() {
        guard let superview = superview else {
            return
        }

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.3),
            heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.3)
        ])
    }

}
