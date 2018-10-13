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
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //ScrollView's contentOffset differences with previous contentOffset
        let contentOffset =  scrollView.contentOffset.y - oldContentOffset.y
      
        // Scrolls UP - we compress the top view
        if contentOffset > 0 && scrollView.contentOffset.y > 0 {
            if ( topViewTopConstraint.constant > -120 ) {
                topViewTopConstraint.constant -= contentOffset
                scrollView.contentOffset.y -= contentOffset
            }
        }
        
        // Scrolls Down - we expand the top view
        if contentOffset < 0 && scrollView.contentOffset.y < 0 {
            if (topViewTopConstraint.constant < 0) {
                if topViewTopConstraint.constant - contentOffset > 0 {
                    topViewTopConstraint.constant = 0
                } else {
                    topViewTopConstraint.constant -= contentOffset
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

