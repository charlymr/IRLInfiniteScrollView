##
## Before you commit to the Podscpec repro, it is good practice to verify your settings via lint
## > pod spec lint IRLInfiniteScrollView.podspec --sources='https://github.com/CocoaPods/Specs'
##
## When done modifying that file simply run:
## > pod trunk push IRLInfiniteScrollView.podspec
##

Pod::Spec.new do |s|

s.name         = "IRLInfiniteScrollView"
s.version      = "0.1.2"
s.summary      = "An infinite ScrollView."
s.description  = "A very simple to implement an infinite scrolling effect to UIScrollView. You can either use the subclass or the extension provided to UIScrollView if you don't want to subclass."
s.license      = { :type => 'GNU GENERAL PUBLIC LICENSE. Denis Martin. Luxembourg', :file => 'LICENSE' }

s.homepage     = "https://github.com/charlymr/IRLInfiniteScrollView"
s.authors      = { 'Denis Martin' => 'support@irlmobile.com' }
s.source       = { :git => 'https://github.com/charlymr/IRLInfiniteScrollView.git', :branch => 'master', :tag => '0.1.2'}

s.platform     = :ios, '8.0'

s.default_subspec = 'Default'

    s.subspec 'Default' do |d|
        d.source_files          = 'Source', 'Source/**/*.{h,m,swift}'
        d.ios.frameworks = 'Foundation', 'UIKit'
        d.requires_arc = true
    end

end