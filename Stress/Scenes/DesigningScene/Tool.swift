//
//  Tool.swift
//  Stress
//
//  Created by Shawn Koh on 21/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

enum ToolType {
    case create(type: PegType)
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
        let diameter = StressSettings.defaultPegRadius * 2
        frame.size = CGSize(width: diameter, height: diameter)
        switch type {
        case .create(type: .normal):
            setImage(StressSettings.defaultPegImage(for: .normal), for: .normal)
            setImage(StressSettings.defaultPegImage(for: .normal, didHit: true), for: .selected)
        case .create(type: .objective):
            setImage(StressSettings.defaultPegImage(for: .objective), for: .normal)
            setImage(StressSettings.defaultPegImage(for: .objective, didHit: true), for: .selected)
        case .delete:
            // TODO: Using the symbol sucks cos we can't adjust the size dynamically this way.
            setImage(UIImage(systemName: "xmark.circle",
                             withConfiguration: UIImage.SymbolConfiguration(pointSize: 150)),
                     for: .normal)
        }
    }
}
