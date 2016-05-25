//
//  DataView.swift
//  demo
//
//  Created by Denis Martin on 25/05/16.
//  Copyright © 2016 iRLMobile. All rights reserved.
//

import UIKit

func generateSomeUIViewForOurDemo(frame: CGRect) -> [UIView] {
    
    var subviews = [UILabel]()
    
    for index in 1...5 {
        let label = UILabel(frame: frame)
        label.backgroundColor = UIColor.lightGrayColor()
        label.text = "\(index)"
        label.textAlignment = .Center
        subviews.append(label)
    }
    
    return subviews
}
