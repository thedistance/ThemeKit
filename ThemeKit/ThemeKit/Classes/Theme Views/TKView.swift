//
//  TKView.swift
//  ThemeKit
//
//  Created by Josh Campion on 31/01/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public protocol BackgroundColourThemeable: Themeable {
    
    var backgroundColourStyle:ColourStyle? { get set }
    
    var backgroundColourStyleId:String? { get set }
    
    func applyBackgroundTheme(theme:Theme)
}

public extension BackgroundColourThemeable where Self:UIView {
    
    public var backgroundColourStyle:ColourStyle? {
        get {
            if let str = backgroundColourStyleId {
                return ColourStyle(rawValue: str)
            } else {
                return nil
            }
        }
        set {
            backgroundColourStyleId = newValue?.rawValue
        }
    }
    
    public func applyBackgroundTheme(theme: Theme) {
        if let bgStyle = backgroundColourStyle {
            backgroundColor = theme.colour(bgStyle)
        }
    }
}

@IBDesignable
public class TKView: UIView, BackgroundColourThemeable, Checking {
    
    let checker = _Checker()
    
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
    
    // --
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateThemeIfNeeded()
    }
    
    // -- Theme Properties
    
    @IBInspectable public var backgroundColourStyleId:String? {
        didSet {
            if backgroundColourStyleId != oldValue {
                setNeedsUpdateTheme()
            }
        }
    }
}

