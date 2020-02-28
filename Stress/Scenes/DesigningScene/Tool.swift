//
//  Tool.swift
//  Stress
//
//  Created by Shawn Koh on 21/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

enum ToolType {
    case create(type: PegType, shape: PegShape)
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
        case .create(type: .orange, shape: .circle):
            setImage(Settings.Peg.image(type: .orange, shape: .circle), for: .normal)
            setImage(Settings.Peg.image(type: .orange, shape: .circle, didHit: true), for: .selected)
        case .create(type: .orange, shape: .triangle):
            setImage(Settings.Peg.image(type: .orange, shape: .triangle), for: .normal)
            setImage(Settings.Peg.image(type: .orange, shape: .triangle, didHit: true), for: .selected)
        case .create(type: .blue, shape: .circle):
            setImage(Settings.Peg.image(type: .blue, shape: .circle), for: .normal)
            setImage(Settings.Peg.image(type: .blue, shape: .circle, didHit: true), for: .selected)
        case .create(type: .blue, shape: .triangle):
            setImage(Settings.Peg.image(type: .blue, shape: .triangle), for: .normal)
            setImage(Settings.Peg.image(type: .blue, shape: .triangle, didHit: true), for: .selected)
        case .create(type: .green, shape: .circle):
            setImage(Settings.Peg.image(type: .green, shape: .circle), for: .normal)
            setImage(Settings.Peg.image(type: .green, shape: .circle, didHit: true), for: .selected)
        case .create(type: .green, shape: .triangle):
            setImage(Settings.Peg.image(type: .green, shape: .triangle), for: .normal)
            setImage(Settings.Peg.image(type: .green, shape: .triangle, didHit: true), for: .selected)
        case .delete:
            // TODO: Using the symbol sucks cos we can't adjust the size dynamically this way.
            setImage(UIImage(systemName: "xmark.circle",
                             withConfiguration: UIImage.SymbolConfiguration(pointSize: 150)),
                     for: .normal)
        }
    }
}
