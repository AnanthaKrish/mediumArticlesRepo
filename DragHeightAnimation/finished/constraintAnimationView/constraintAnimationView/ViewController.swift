//
//  ViewController.swift
//  constraintAnimationView
//
//  Created by Anantha Krishnan K G on 30/10/18.
//  Copyright © 2018 Ananth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var imageViewButton: UIImageView!
    @IBOutlet var verticalConstraintObj: NSLayoutConstraint!
    
    
    var minHeight:CGFloat = 0.0
    var viewCenter:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewButton.modifyView()
        viewCenter = self.view.frame.height / 2
        minHeight = viewCenter - 60
        
        let panGest = PanVerticalScrolling(target: self, action: #selector(ViewController.panAction(sender:)))
        
        imageViewButton.addGestureRecognizer(panGest)
        
    }
    
    @objc func panAction(sender: UIPanGestureRecognizer) {
        
        
        if sender.state == .changed {
            
            let endPossition = sender.location(in: self.view)
            
            let differenceHeight = endPossition.y - viewCenter
            
            if differenceHeight > -minHeight && differenceHeight < minHeight {
                
                verticalConstraintObj.constant = differenceHeight
                
                self.view.layoutIfNeeded()
            }
        }
    }
}

class PanVerticalScrolling : UIPanGestureRecognizer {
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        
        super.touchesMoved(touches, with: event)
        
        if state == .began {
            
            let vel = velocity(in: self.view)
            
            if abs(vel.x) > abs(vel.y) {
                state = .cancelled
            }
        }
    }
}


extension UIView {
    
    func modifyView() {
       
        self.layer.cornerRadius = self.frame.height / 2
    }
}
