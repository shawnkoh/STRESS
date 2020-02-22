//
//  Stage.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Stage: GKView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override init() {
        super.init()
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.cornerRadius = 16
    }

    override func didMoveToSuperview() {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16),
            heightAnchor.constraint(equalToConstant: 800)
        ])
    }
}
