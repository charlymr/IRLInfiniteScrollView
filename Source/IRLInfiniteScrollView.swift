//
//  IRLInfiniteScrollView.swift
//  demo
//
//  Created by Denis Martin on 13/05/2016.
//  Copyright © 2016 iRLMobile. All rights reserved.
//

import Foundation
import UIKit


/**
 This class will provide an infinite scrolling mechanism.
 
 - important: Your views width must be the same
 
 
 - Make sure you implement UIScrollViewDelegate func scrollViewDidScroll(scrollView: UIScrollView)
 - Setup func setupInfiniteScroll(subviews subViews: [UIView], margin: CGFloat?)
 
 - Call  func scrollView.reoderScrollingStack() in your delegate method: func scrollViewDidScroll(scrollView: UIScrollView)
 */
public class IRLInfiniteScrollView: UIScrollView {
    
    /**
     Setup an horizontal infinite UIScrollView. your Subviews must be of the same width and it will be enforce
     
     - important: The views width must be the same and it is enforce when calling this method
     
     - parameter subviews: An array of UIView to be inserted in the UIScrollView
     - parameter beforeMargin: Optional margin before your views.
     - parameter afterMargin: Optional margin after your views.
     */
    func setupInfiniteScroll(subviews subViews: [UIView], beforeMargin: CGFloat?, afterMargin: CGFloat?) {
        
        guard let firstView = subViews.first else {
            return
        }
        
        for view in subViews {
            assert(view.bounds.size.width == firstView.bounds.size.width, "One of your view is not matching the first view provided width!")
        }
        
        for view in subViews {
            view.removeFromSuperview()
        }
        
        self.beforeMargin   = beforeMargin ?? 0
        self.afterMargin  = afterMargin ?? 0

        subviewsWidth   = firstView.bounds.size.width
        infinitSubViews = subViews
        
        setupInfiniteScroll(subviews: subViews, subviewsWidth: subviewsWidth, beforeMargin: self.beforeMargin, afterMargin: self.afterMargin)
        
        if self.beforeMargin > 0 {
            moveScrollToNearestCard(subviewsWidth: subviewsWidth, beforeMargin: self.beforeMargin, afterMargin: self.afterMargin)
        }
        
    }
    
    /**
     You should be Call this method in your delegate scrollViewDidScroll(scrollView: UIScrollView)
     
     - see: func scrollViewDidScroll(scrollView: UIScrollView)
     */
    func reoderScrollingStack() {
        reoderScrollingStack(subviews: infinitSubViews, subviewsWidth: subviewsWidth, beforeMargin: beforeMargin, afterMargin: afterMargin)
    }
    
    /**
     You should be Call this method in your delegate scrollViewDidScroll(scrollView: UIScrollView)
     
     - see: func scrollViewDidScroll(scrollView: UIScrollView)

     - parameter scale: The variable scale between views. Default is 0.3 so a half visible view will have a scale of 0.85 ... ex. (1 - scale / 0.5)

     */
    func reoderScrollingStackWithScale(scale: CGFloat = 0.3) {
        reoderScrollingStackWithScale(subviews: infinitSubViews, subviewsWidth: subviewsWidth, beforeMargin: beforeMargin, afterMargin: afterMargin, scale: scale)
    }
    
    /**
     This is optional and can be use to stick teh neares view to the edge when decelerating.
     This method should be call in your delegate scrollViewDidEndDecelerating(scrollView: UIScrollView)
     
     - see: func scrollViewDidEndDecelerating(scrollView: UIScrollView)
     */
    func moveScrollToNearestCard() {
        moveScrollToNearestCard(subviewsWidth: subviewsWidth, beforeMargin: beforeMargin, afterMargin: afterMargin)
    }
    
    /**
     This is optional and can be use to stick teh neares view to the edge when decelerating.
     This method should be call in your delegate scrollViewDidEndDecelerating(scrollView: UIScrollView)
     
     - see: func scrollViewDidEndDecelerating(scrollView: UIScrollView)
     */
    func centeScrollToNearestCard() {
        centerScrollToNearestCard(subviewsWidth: subviewsWidth, beforeMargin: beforeMargin, afterMargin: afterMargin)
    }
    
    /**
     This is optional and can be Call Anytime you want to scroll to a particular Idnex.
     
     - parameter index: The Idnex you wish to move to.
     - parameter animated: If it should be animated or not
     */
    func centerScrollToCardAtIndex(index: UInt, animated: Bool) {
        centerScrollToCardAtIndex(index: index, objectCounts: UInt(infinitSubViews.count), subviewsWidth: subviewsWidth, beforeMargin: beforeMargin, afterMargin: afterMargin, animated: animated)
    }
    
    private var beforeMargin:     CGFloat = 0
    private var afterMargin:    CGFloat   = 0
    private var subviewsWidth:  CGFloat   = 0
    private var infinitSubViews           = [UIView]()
    
}



// Setup
public extension UIScrollView {
    
    /**
     Setup an horizontal infinite UIScrollView. your Subviews must be of the same width and it will be enforce by subviewsWidth
     
     - important: The views width must be the same and it is enforce when calling this method
     
     - parameter subviews: An array of UIView to be inserted in the UIScrollView
     - parameter subviewsWidth: The width to be use for the subviews. Warning you must have the same witdh as the subviews you give or this method will fail
     - parameter beforeMargin: Optional margin before your views.
     - parameter afterMargin: Optional margin after your views.
     */
    func setupInfiniteScroll(subviews subViews: [UIView],  subviewsWidth: CGFloat, beforeMargin: CGFloat, afterMargin: CGFloat) {
        
        // Some Checks
        for view in subViews {
            assert(view.bounds.size.width == subviewsWidth, "One of your view is not matching your average subviewsWidth!")
        }
        
        guard let _ = delegate else {
            fatalError("Your UIScrollView doesn't have a delegate associated with it. You must call reoderScrollingStack(subviews: subviewsWidth: subviewsMargin:) in your delegate method func scrollViewDidScroll(scrollView: UIScrollView) in order for the infinite loop to work.")
        }
        
        let mWidth              = beforeMargin + subviewsWidth + afterMargin
        
        let maxValue: CGFloat   = mWidth * 10000 // A Big number
        
        for (index, cardView) in subViews.enumerated() {
            
            let frame = CGRect(
                x:      mWidth * CGFloat(index),
                y:      cardView.frame.origin.y,
                width:  subviewsWidth,
                height: cardView.bounds.size.height)
            
            cardView.frame = frame
            
            contentSize = CGSize(width: maxValue, height: contentSize.height)
            addSubview(cardView)
            
        }
        
        if contentOffset.x == 0 {
            contentOffset = CGPoint(x: maxValue/2, y: contentOffset.y)
        }
        
    }
}

// Reordering
public extension UIScrollView {
    
    /**
     You should be Call this method in your delegate scrollViewDidScroll(scrollView: UIScrollView)
     
     - important: The views width must be the same and it is enforce when calling this method
     - see: func scrollViewDidScroll(scrollView: UIScrollView)

     - parameter subviews: An array of UIView to be inserted in the UIScrollView
     - parameter subviewsWidth: The width to be use for the subviews. Warning you must have the same witdh as the subviews you give or this method will fail
     - parameter beforeMargin: Optional margin before your views.
     - parameter afterMargin: Optional margin after your views.
     */
    func reoderScrollingStack(subviews subViews: [UIView], subviewsWidth: CGFloat, beforeMargin: CGFloat, afterMargin: CGFloat ) {
        
        for view in subViews {
            assert(view.bounds.size.width == subviewsWidth, "One of your view is not matching your average subviewsWidth!")
        }
        _reorderViews(subviews: subViews, subviewsWidth: subviewsWidth, beforeMargin: beforeMargin, afterMargin: afterMargin)

    }
    
    /**
     You should be Call this method in your delegate scrollViewDidScroll(scrollView: UIScrollView)
     
     - see: func scrollViewDidScroll(scrollView: UIScrollView)
     
     - parameter subviews: An array of UIView to be inserted in the UIScrollView
     - parameter subviewsWidth: The width to be use for the main view.
     - parameter beforeMargin: Optional margin before your views.
     - parameter afterMargin: Optional margin after your views.
     - parameter scale: The variable scale between views. Default is 0.3 so a half visible view will have a scale of 0.85 ... ex. (1 - scale / 0.5)
     */
    func reoderScrollingStackWithScale(subviews subViews: [UIView], subviewsWidth: CGFloat, beforeMargin: CGFloat, afterMargin: CGFloat, scale: CGFloat = 0.3 ) {
        _reorderViews(subviews: subViews, subviewsWidth: subviewsWidth, beforeMargin: beforeMargin, afterMargin: afterMargin)
        
        for view in subViews {
            
            let union = view.frame.union(CGRect(origin: contentOffset, size: bounds.size))
            
            if union.size.width > 1 {
                
                var scaleFactor: CGFloat = 1 - (union.size.width / view.bounds.size.width)
                scaleFactor = scaleFactor < -1 ? -1 : scaleFactor
                scaleFactor = scaleFactor > 0 ? 0 : scaleFactor
                let normScale   = 1 + (scale * scaleFactor)
               let transform  = CGAffineTransform(scaleX: normScale, y: normScale)
                view.transform = transform

            }
            
            if union.size.width == view.bounds.size.width {
                bringSubview(toFront: view)
            }
            
        }

    }
}

// Work with the Offset
public extension UIScrollView {
    
    /**
     This is optional and can be use to stick the neares view to the edge when decelerating.
     This method should be call in your delegate scrollViewDidEndDecelerating(scrollView: UIScrollView)
     
     - see: func scrollViewDidEndDecelerating(scrollView: UIScrollView)

     - parameter subviewsWidth: The width to be use for the subviews. Warning you must have the same witdh as the subviews you give or this method will fail
     - parameter beforeMargin: Optional margin before your views.
     - parameter afterMargin: Optional margin after your views.
     */
    func moveScrollToNearestCard(subviewsWidth: CGFloat, beforeMargin: CGFloat, afterMargin: CGFloat) {
        
        if contentOffset.x + bounds.size.width + 20 > contentSize.width {
            return
        }
        
        let mWidth         = beforeMargin + subviewsWidth + afterMargin
        
        let normalizedX    = round(contentOffset.x/mWidth) * mWidth - beforeMargin
        setContentOffset(CGPoint(x: normalizedX, y: contentOffset.y), animated: true)
        
    }
    
    /**
     This is optional and can be use to center nearest view when decelerating.
     This method should be call in your delegate scrollViewDidEndDecelerating(scrollView: UIScrollView)
     
     - see: func scrollViewDidEndDecelerating(scrollView: UIScrollView)
     
     - parameter subviewsWidth: The width to be use for the subviews. Warning you must have the same witdh as the subviews you give or this method will fail
     - parameter beforeMargin: Optional margin before your views.
     - parameter afterMargin: Optional margin after your views.
     */
    func centerScrollToNearestCard(subviewsWidth: CGFloat, beforeMargin: CGFloat, afterMargin: CGFloat) {
        
        if contentOffset.x + bounds.size.width + 20 > contentSize.width {
            return
        }
        
        let mWidth         = beforeMargin + subviewsWidth + afterMargin
        let normalizedX    = round(contentOffset.x/mWidth) * mWidth - beforeMargin
        
        setContentOffset(CGPoint(x: normalizedX, y: contentOffset.y), animated: true)
        
    }
    
    /**
     This method let you mmove to a paticular index
     
     - parameter index: The Idnex you wish to move to.
     - parameter objectCounts: Number of objects.
     - parameter subviewsWidth: The width to be use for the subviews. Warning you must have the same witdh as the subviews you give or this method will fail
     - parameter beforeMargin: Optional margin before your views.
     - parameter afterMargin: Optional margin after your views.
     */
    func centerScrollToCardAtIndex(index: UInt, objectCounts: UInt, subviewsWidth: CGFloat, beforeMargin: CGFloat, afterMargin: CGFloat, animated: Bool) {

        let mWidth           = beforeMargin + subviewsWidth + afterMargin
        
        let normalizedX      = round(contentOffset.x/mWidth) * mWidth
        let scrollFact       = UInt (normalizedX / mWidth)
        let scrollOffetFact  = UInt (scrollFact / objectCounts) * objectCounts
        let xFirstIndex      = CGFloat (scrollOffetFact) * mWidth - beforeMargin
        let offsetX          = xFirstIndex + mWidth * CGFloat (index)
        
        setContentOffset(CGPoint(x: offsetX, y: contentOffset.y), animated: true)
        
    }
    
    
}

private extension UIScrollView {
    
    func _reorderViews(subviews subViews: [UIView], subviewsWidth: CGFloat, beforeMargin: CGFloat, afterMargin: CGFloat ) {
        
        let mWidth                   = beforeMargin + subviewsWidth + afterMargin
        
        let objects                  = subViews.count
        let visibleOffset            = Int(contentOffset.x / mWidth)
        let firstOffset              = Int(visibleOffset / objects) * objects
        
        func swizzle(zeView: UIView, index: Int) {
            
            let originX = mWidth * CGFloat(index)
            
            let frame = CGRect(
                x:      originX,
                y:      zeView.frame.origin.y,
                width:  subviewsWidth,
                height: zeView.frame.size.height)
            
            zeView.frame = frame
            
        }
        
        // Stack swizle here
        for (index,view) in subViews.enumerated() {
            swizzle(zeView: view, index: firstOffset+index)
            
            if self.contentOffset.x > view.frame.origin.x + view.frame.size.width {
                swizzle(zeView: view, index: firstOffset+index+objects)
            }
            
        }

    }
    
}
