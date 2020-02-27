//
//  PegView.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class PegView: UIImageView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    init(shape: PegShape, isObjective: Bool) {
        super.init(frame: .zero)
        image = StressSettings.defaultPegImage(for: shape, isObjective: isObjective)
        let diameter = StressSettings.defaultPegRadius * 2
        frame.size = CGSize(width: diameter, height: diameter)
    }

    override func removeFromSuperview() {
        UIView.animate(withDuration: StressSettings.defaultPegFadeDuration, animations: {
            self.alpha = 0.0
        }, completion: { finished in
            if finished {
                // TODO: This causes a crash if the user quits the level before the callback is triggered.
                // FIX: Use a manual timer by counting frames instead of a callback.
                super.removeFromSuperview()
            }
        })
    }
}
