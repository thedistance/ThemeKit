//
//  TKWindow.swift
//  ThemeKit
//
//  Created by Josh Campion on 02/08/2015.
//  Copyright © 2015 Josh Campion. All rights reserved.
//

import UIKit

public class TKThemeVendor: NSSingleton {
    
    public var defaultTheme:Theme?
    
//    public func defaultTheme() -> Theme? {
//        return nil
//    }
}

@IBDesignable
public class TKView: UIView, Themeable {
    
    // - initWithFrame(_:) support
    public var createdFromNib:Bool = false
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        createdFromNib = true
    }
    
     public override func didMoveToSuperview() {
            super.didMoveToSuperview()
        
        if let theme = theme() where !createdFromNib {
            applyTheme(theme)
        }
    }
    
    // -- setNeedsUpdateTheme() support
    private var _needsUpdateTheme = true
    
    public func setNeedsUpdateTheme() {
        _needsUpdateTheme = true
        setNeedsLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if _needsUpdateTheme {
            if let t = self.theme() {
                self.applyTheme(t)
            }
            _needsUpdateTheme = false
        }
    }
    
    // --
    public var backgroundColourStyle:ColourStyle? {
        didSet {
            if oldValue != backgroundColourStyle {
                setNeedsUpdateTheme()
            }
        }
    }
    
    @IBInspectable public var backgroundColourStyleId:String? {
        set {
            if let idString = newValue,
                let style = ColourStyle(rawValue:idString) {
                    backgroundColourStyle = style
            }
        }
        get {
            return backgroundColourStyle?.rawValue
        }
    }
    
    public func applyTheme(theme:Theme) {
     
        if let bgStyle = backgroundColourStyle {
            backgroundColor = theme.colour(bgStyle)
        } else {
            backgroundColor = UIColor.whiteColor()
        }
    }
}

/*
public class TKWindow: UIWindow {

    public class func themeType() -> Theme.Type? {
        return nil
    }
    
    private static var _theme:Theme?
    
    public static var theme:Theme? {
        get {
            if _theme == nil {
                _theme = self.themeType()?.init()
            }
            
            return _theme
        } set {
            _theme = newValue
        }
    }
}
*/