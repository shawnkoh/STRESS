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

    init(type: PegType) {
        super.init(frame: .zero)
        image = StressSettings.defaultPegImage(for: type)
        let diameter = StressSettings.defaultPegRadius * 2
        frame.size = CGSize(width: diameter, height: diameter)
    }

    override func removeFromSuperview() {
        UIView.animate(withDuration: StressSettings.defaultPegFadeDuration, animations: {
            self.alpha = 0.0
        }, completion: { finished in
            if finished {
                super.removeFromSuperview()
            }
        })
    }
}
