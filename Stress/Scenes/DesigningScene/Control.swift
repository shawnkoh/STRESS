//
//  Control.swift
//  Stress
//
//  Created by Shawn Koh on 21/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

enum ControlType: String {
    case back
    case reset
    case load
    case save
    case play
}

class Control: UIButton {
    let action: () -> Void

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    init(type: ControlType, action: @escaping () -> Void) {
        self.action = action
        super.init(frame: .zero)
        let diameter = Settings.Peg.radius * 2
        frame.size = CGSize(width: diameter, height: diameter)
        setTitle(type.rawValue, for: .normal)
        switch type {
        case .play:
            setTitleColor(.green, for: .normal)
        default:
            setTitleColor(.blue, for: .normal)
        }
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }

    @objc private func touchUpInside() {
        action()
    }
}
