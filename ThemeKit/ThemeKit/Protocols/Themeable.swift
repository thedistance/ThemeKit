//
//  Themeable.swift
//  ThemeKit
//
//  Created by Josh Campion on 31/01/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit
import ObjectiveC

public protocol Themeable: class {
    
    var createdFromNib:Bool { get set }
    
    func theme() -> Theme?
    
    /// Sets properties based on *Themeable protocol properties. A default implementation is provided for `UIView`s.
    func applyTheme(_ theme:Theme)

    /// A default implementation is provided for `UIView`s.
    func setNeedsUpdateTheme()
    
    /// A default implementation is provided for `UIView`s.
    func updateThemeIfNeeded()
}

public extension Themeable {
    
    public func applyProtocolThemes(_ theme:Theme) {
        if let backgroundSelf = self as? BackgroundColourThemeable {
            backgroundSelf.applyBackgroundTheme(theme)
        }
        
        if let tintSelf = self as? TintColourThemeable {
            tintSelf.applyTintTheme(theme)
        }
        
        if let textSelf = self as? TextThemeable {
            textSelf.applyTextTheme(theme)
        }
        
        if let thumbSelf = self as? ThumbTintColourThemeable {
            thumbSelf.applyThumbTintTheme(theme)
        }
        
        if let barSelf = self as? BarThemeable {
            barSelf.applyBarTheme(theme)
        }
    }
    
    func applyTheme(_ theme:Theme) {
        applyProtocolThemes(theme)
    }
    
    /// calls `setNeedsUpdateTheme() iff the values have changed.
    func checkAndUpdateColourStyle(_ oldValue:ColourStyle?, _ newValue:ColourStyle?) {
        if (oldValue != newValue) {
            setNeedsUpdateTheme()
        }
    }
    
    /// calls `setNeedsUpdateTheme() iff the values have changed.
    func checkAndUpdateTextStyle(_ oldValue:TextStyle?, _ newValue:TextStyle?) {
        if (oldValue != newValue) {
            setNeedsUpdateTheme()
        }
    }
}

private var ThemeableNeedsUpdateThemeKey:UInt8 = 0

public extension Themeable where Self:UIView {
    
    func theme() -> Theme? {

        // to re-add when allowing multiple themes.
//        if let svTheme = (superview as? Themeable)?.theme() {
//            return svTheme
//        }
        
        let vendor = TKThemeVendor.shared()
        let theme = vendor?.defaultTheme
        return theme
    }
    
    // private variable to support the `setNeedsUpdateTheme()` and `updateThemeIfNeeded()` extensions.
    fileprivate var _needsUpdateTheme:Bool {
        get {
            return (objc_getAssociatedObject(self, &ThemeableNeedsUpdateThemeKey) as? NSNumber)?.boolValue ?? true
        }
        set {
            objc_setAssociatedObject(self, &ThemeableNeedsUpdateThemeKey, NSNumber(value: newValue as Bool), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func setNeedsUpdateTheme() {
        _needsUpdateTheme = true
        setNeedsLayout()
    }
    
    public func updateThemeIfNeeded() {
        if _needsUpdateTheme {
            if let t = self.theme() {
                self.applyTheme(t)
            }
            _needsUpdateTheme = false
        }
    }
}

public extension Themeable where Self:UIBarItem {
    
    func theme() -> Theme? {
        
        // to re-add when allowing multiple themes.
        //        if let svTheme = (superview as? Themeable)?.theme() {
        //            return svTheme
        //        }
        
        let vendor = TKThemeVendor.shared()
        let theme = vendor?.defaultTheme
        return theme
    }
    
    // private variable to support the `setNeedsUpdateTheme()` and `updateThemeIfNeeded()` extensions.
    fileprivate var _needsUpdateTheme:Bool {
        get {
            return (objc_getAssociatedObject(self, &ThemeableNeedsUpdateThemeKey) as? NSNumber)?.boolValue ?? true
        }
        set {
            objc_setAssociatedObject(self, &ThemeableNeedsUpdateThemeKey, NSNumber(value: newValue as Bool), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func setNeedsUpdateTheme() {
        _needsUpdateTheme = true
        updateThemeIfNeeded()
    }
    
    public func updateThemeIfNeeded() {
        if _needsUpdateTheme {
            if let t = self.theme() {
                self.applyTheme(t)
            }
            _needsUpdateTheme = false
        }
    }
}
