//
//  CardView.swift
//  MoviesTonight
//
//  Created by Pawan on 13/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit

/// To give bouchy animation on tap
class CardView: UIView {

    var animationDuration = 0.2
    var downScale:CGFloat = 0.955
    
    var didScaleDownOnTouch = false
    
    override func draw(_ rect: CGRect) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.didScaleDownOnTouch = false
        self.setTouchDownState()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.setTouchUpStateWithAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.setTouchUpStateWithAnimation()
    }
    
    func setTouchDownState() {
        UIView.animate(withDuration: self.animationDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.4, options: .curveLinear, animations: {
            self.transform = CGAffineTransform.init(scaleX: self.downScale, y: self.downScale)
        }) { (completed) in
            self.didScaleDownOnTouch = true
        }
    }
    
    func setTouchUpStateWithAnimation() {
        UIView.animate(withDuration: self.animationDuration*2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }) { (completed) in }
    }

}
