
# IRLInfiniteScrollView

An Infinite UIScrollView.

![Demo](https://github.com/charlymr/IRLInfiniteScrollView/blob/master/Medias/iphone-scroll.gif?raw=true)
![Licence](https://img.shields.io/packagist/l/doctrine/orm.svg)

A very simple to implement infinite scrolling effect to UIScrollView. You can either use the subclass or the extension provided to UIScrollView if you don't want to subclass.

**MINIMUM iOS REQUIREMENT: 8.0**

**This Project use Swift**

## Installation

The recommended approach for installing IRLDocumentScanner is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation. For best results, it is recommended that you install via CocoaPods **>= 0.19.1** using Git **>= 1.8.0** installed via Homebrew.

### via CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project, and Create and Edit your Podfile and add RestKit:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
platform :ios, '8.0'
pod 'IRLInfiniteScrollView', '~> 0.1'

### Manually

- [Download IRLInfiniteScrollView](../../archive/master.zip)
- Copy to your project this file: <strong> IRLInfiniteScrollView.swift </strong>
- Make sure your project link to  <strong>  'Foundation', 'UIKit'</strong>




## Getting Started

IRLInfiniteScrollView is designed to be a flexible drop in dependency. 

You can either use the provided sublcass IRLInfiniteScrollView or the extension to UIScrollView


## Examples

### Swift using the provided IRLInfiniteScrollView subclass

``` Swift
    
    @IBOutlet weak var scrollView: IRLInfiniteScrollView!
    
    //MARK: View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subviews   = someCustomUIViewElements()
        scrollView.delegate = self
        scrollView.setupInfiniteScroll(subviews: subviews, beforeMargin: 10, afterMargin: 10)
        
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
    
```

### Swift using the UIScrollView extension

``` Swift
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var subviews = [UIView]()
    
    //MARK: View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        subviews   = someCustomUIViewElements()
        scrollView.delegate = self
        scrollView.setupInfiniteScroll(subviews: subviews, beforeMargin: 10, afterMargin: 10)
        
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.reoderScrollingStack(subviews: subviews, subviewsWidth: 750/2, beforeMargin: 10, afterMargin: 10)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // Optional move the view
        scrollView.moveScrollToNearestCard(750/2, beforeMargin: 10, afterMargin: 10)
    }

    
```

## Authors

- Denis Martin | Web: [www.irlmobile.com](http://www.irlmobile.com)


## Open Source

- Feel free to fork and modify this code. Pull requests are more thant welcome!



## License

**The MIT License (MIT)**

Copyright (c) 2016 Denis Martin. 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
