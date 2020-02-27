//
//  Tool.swift
//  Stress
//
//  Created by Shawn Koh on 21/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

enum ToolType {
    case create(shape: PegShape, isObjective: Bool)
    case delete
}

class Tool: UIButton {
    let type: ToolType
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    init(type: ToolType) {
        self.type = type
        super.init(frame: .zero)
        let diameter = Settings.Peg.radius * 2
        frame.size = CGSize(width: diameter, height: diameter)
        switch type {
        case .create(shape: .circle, isObjective: true):
            setImage(Settings.Peg.image(for: .circle, isObjective: true), for: .normal)
            setImage(Settings.Peg.image(for: .circle, isObjective: true, didHit: true), for: .selected)
        case .create(shape: .circle, isObjective: false):
            setImage(Settings.Peg.image(for: .circle), for: .normal)
            setImage(Settings.Peg.image(for: .circle, didHit: true), for: .selected)
        case .create(shape: .triangle, isObjective: true):
            setImage(Settings.Peg.image(for: .triangle, isObjective: true), for: .normal)
            setImage(Settings.Peg.image(for: .triangle, isObjective: true, didHit: true), for: .selected)
        case .create(shape: .triangle, isObjective: false):
            setImage(Settings.Peg.image(for: .triangle), for: .normal)
            setImage(Settings.Peg.image(for: .triangle, didHit: true), for: .selected)
        case .delete:
            // TODO: Using the symbol sucks cos we can't adjust the size dynamically this way.
            setImage(UIImage(systemName: "xmark.circle",
                             withConfiguration: UIImage.SymbolConfiguration(pointSize: 150)),
                     for: .normal)
        }
    }
}
