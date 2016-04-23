//
//  ThemeNavigationBar.swift
//  ThemeKit
//
//  Created by Josh Campion on 07/02/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit
import ThemeKitCore

@IBDesignable
public class ThemeNavigationBar: TKNavigationBar, IBThemeable {
    
    // Only instance properties can be declared IBInspectable
    @IBInspectable
    override public var tintColourStyleId:String? { didSet { } }
    
    // Only instance properties can be declared IBInspectable
    @IBInspectable
    override public var textStyleId:String? { didSet { } }
    
    // Only instance properties can be declared IBInspectable
    @IBInspectable
    override public var textColourStyleId:String? { didSet { } }
    
    // Only instance properties can be declared IBInspectable
    @IBInspectable
    override public var barTintColourStyleId:String? { didSet { } }
}