//
//  Cell.swift
//  Stress
//
//  Created by Shawn Koh on 23/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Cell: ScalingCarouselCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        mainView = UIView(frame: contentView.bounds)
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
