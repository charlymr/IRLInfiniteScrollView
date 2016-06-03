//
//  ViewController.swift
//  demo
//
//  Created by Denis Martin on 13/05/2016.
//  Copyright © 2016 iRLMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: IRLInfiniteScrollView!
    
    //MARK: View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelFrame = CGRectMake(0, 10, 750/2-20, scrollView.bounds.size.height-20)
        let subviews   = generateSomeUIViewForOurDemo(labelFrame)
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.setupInfiniteScroll(subviews: subviews, beforeMargin: 10, afterMargin: 10)
        
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if let infiniteScrollView = scrollView as? IRLInfiniteScrollView {
            infiniteScrollView.reoderScrollingStack()
        }
    }
    
     func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            scrollViewDidEndDecelerating(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // Optional move the view
        if let infiniteScrollView = scrollView as? IRLInfiniteScrollView {
            infiniteScrollView.centeScrollToNearestCard()
        }
    }
    
    
    @IBAction func scrollTo(sender: UIButton) {
     
        let index = UInt( sender.titleForState(.Normal)! )!
        scrollView.centerScrollToCardAtIndex(index, animated: true)
        
    }
    
}



