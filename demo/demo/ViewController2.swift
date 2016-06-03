//
//  ViewController2.swift
//  demo
//
//  Created by Denis Martin on 25/05/16.
//  Copyright © 2016 iRLMobile. All rights reserved.
//

import UIKit

class ViewControllerWithoutSublclassingUISScrollView: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var subviews = [UIView]()
    
    //MARK: View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelFrame = CGRectMake(0, 10, 750/2, scrollView.bounds.size.height-10)
        subviews   = generateSomeUIViewForOurDemo(labelFrame)
        
        scrollView.setupInfiniteScroll(subviews: subviews, subviewsWidth: 750/2, beforeMargin: 10, afterMargin: 10)
        
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.reoderScrollingStack(subviews: subviews, subviewsWidth: 750/2, beforeMargin: 10, afterMargin: 10)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // Optional move the view
        scrollView.moveScrollToNearestCard(750/2, beforeMargin: 10, afterMargin: 10)
    }
    
    @IBAction func scrollTo(sender: UIButton) {
        
        let index = UInt( sender.titleForState(.Normal)! )!
        scrollView.centerScrollToCardAtIndex(index, objectCounts: UInt(subviews.count), subviewsWidth: 750/2-20, beforeMargin: 10, afterMargin: 10, animated: true)
        
    }
    
}