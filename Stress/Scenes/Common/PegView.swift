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

    init(type: PegType, shape: PegShape, size: CGSize) {
        super.init(frame: .zero)
        image = Settings.Peg.image(type: type, shape: shape)
        frame.size = size
    }

    override func removeFromSuperview() {
        UIView.animate(withDuration: Settings.Peg.fadeDuration, animations: {
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
