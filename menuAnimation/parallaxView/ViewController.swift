//
//  ViewController.swift
//  parallaxView
//
//  Created by Anantha Krishnan K G on 13/10/18.
//  Copyright © 2018 Ananth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var topViewTopConstraint: NSLayoutConstraint!
    var oldContentOffset = CGPoint.zero

    @IBOutlet var topView: UIView!
    
    @IBOutlet var menuBottomConstraints: NSLayoutConstraint!
    @IBOutlet var menuUpConstraints: NSLayoutConstraint!
    
    @IBOutlet var menuView: UIView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        menuView.modifyView()
        
    }

    // Animate constraint
    func animateConstraints() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //ScrollView's contentOffset differences with previous contentOffset
        let contentOffset =  scrollView.contentOffset.y - oldContentOffset.y
      
        // Scrolls UP - we compress the top view
        if contentOffset > 0 && scrollView.contentOffset.y > 0 {
            if ( topViewTopConstraint.constant > -120 ) {
                topViewTopConstraint.constant -= contentOffset
                scrollView.contentOffset.y -= contentOffset
            } else {
                if(menuUpConstraints.isActive) {
                    print("here 1")
                    menuBottomConstraints.isActive = true
                    menuUpConstraints.isActive = false
                    animateConstraints()
                }
            }
        }
        
        // Scrolls Down - we expand the top view
        if contentOffset < 0 && scrollView.contentOffset.y < 0 {
            if (topViewTopConstraint.constant < 0) {
                if topViewTopConstraint.constant - contentOffset > 0 {
                    topViewTopConstraint.constant = 0
                } else {
                    topViewTopConstraint.constant -= contentOffset
                    if(!menuUpConstraints.isActive) {
                        print("here 2")
                        menuBottomConstraints.isActive = false
                        menuUpConstraints.isActive = true
                        animateConstraints()
                    }
                }
                scrollView.contentOffset.y -= contentOffset
            }
        }
        oldContentOffset = scrollView.contentOffset
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //cells count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        return cell
    }
    
    
    
}


// Round Button
extension UIView {
    
    func modifyView() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = frame.width / 2
    }
    
}

