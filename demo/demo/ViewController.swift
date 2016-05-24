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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelFrame = CGRectMake(0, 10, 750/2, scrollView.bounds.size.height-10)
        
        var subviews = [UILabel]()
        
        for index in 1...5 {
            let label = UILabel(frame: labelFrame)
            label.backgroundColor = UIColor.lightGrayColor()
            label.text = "\(index)"
            label.textAlignment = .Center
            subviews.append(label)
        }
        
        scrollView.setupInfiniteScroll(subviews: subviews, margin: 10)
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if let infiniteScrollView = scrollView as? IRLInfiniteScrollView {
            infiniteScrollView.reoderScrollingStack()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // Optional move the view
        if let infiniteScrollView = scrollView as? IRLInfiniteScrollView {
            infiniteScrollView.moveScrollToNearestCard()
        }
    }
    
}




class ViewControllerWithoutSublclassingUISScrollView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!

    var subviews = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelFrame = CGRectMake(0, 10, 360, scrollView.bounds.size.height-10)
        
        for index in 1...5 {
            let label = UILabel(frame: labelFrame)
            label.backgroundColor = UIColor.lightGrayColor()
            label.text = "\(index)"
            label.textAlignment = .Center
            subviews.append(label)
        }
        
        scrollView.setupInfiniteScroll(subviews: subviews, subviewsWidth: 360, subviewsMargin: 10)
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.reoderScrollingStack(subviews: subviews, subviewsWidth: 360, subviewsMargin: 10)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // Optional move the view
        scrollView.moveScrollToNearestCard(360, subviewsMargin: 10)
    }
    
}