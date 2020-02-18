//
//  PegView.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class PegView: UIImageView {
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
