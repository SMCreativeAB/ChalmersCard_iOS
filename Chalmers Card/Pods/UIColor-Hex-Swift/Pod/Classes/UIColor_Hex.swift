//
//  UIColor_Hex.swift
//  Pods
//
//  Created by Frederik Jacques on 30/05/15.
//
//  This extension is a port of the Objective-C version made by Tom Adriaenssen (@inferis)
//  https://github.com/Inferis/UIColor-Hex
//

import Foundation

public extension String {
    
    func `repeat`( _ times:Int) -> String {
        
        var str = self
        
        for _ in 1 ..< times {
          str.append(self)
        }
        
        return str
    }
    
}

public extension UIColor {
    
    /**
    Create an UIColor object based on a CSS color string
    
    - parameter css:     The CSS color string
    
    - returns: A new UIColor object
    */
    public class func colorWithCSS( _ css:String ) -> UIColor {
        var css = css
        
        // If the string is empty, return black color
        if( css.isEmpty ) { return UIColor.black }
        
        // If the string contains #, remove it from the string
        if( css.hasPrefix("#") ){
            
            css.remove(at: css.startIndex)
            
        }
        
        var redChannel = "0x", greenChannel = "0x", blueChannel = "0x", alphaChannel = "0x"
        var redChannelInt = UInt32(0), greenChannelInt = UInt32(0), blueChannelInt = UInt32(0), alphaChannelInt = UInt32(0)
        let amountOfCharactersInCSSString = css.characters.count
        
        // Handle different CSS color cases
        switch( amountOfCharactersInCSSString ){
            
        case 1 : // #e => #eeeeeeff
            
            redChannel += css.substring(with: (css.startIndex ..< css.characters.index(css.startIndex, offsetBy: 1))).`repeat`(2)
            greenChannel = redChannel
            blueChannel = redChannel
            alphaChannel += "ff"
            
        case 2 : // #f0 => #f0f0f0ff
            
            redChannel += css.substring(with: (css.startIndex ..< css.characters.index(css.startIndex, offsetBy: 2))).`repeat`(1)
            greenChannel = redChannel
            blueChannel = redChannel
            alphaChannel += "ff"
            
        case 3 : // #123 => #112233ff
            
            redChannel += css.substring(with: (css.startIndex ..< css.characters.index(css.startIndex, offsetBy: 1))).`repeat`(2)
            greenChannel += css.substring(with: (css.characters.index(css.startIndex, offsetBy: 1) ..< css.characters.index(css.startIndex, offsetBy: 2))).`repeat`(2)
            blueChannel += css.substring(with: (css.characters.index(css.startIndex, offsetBy: 2) ..< css.characters.index(css.startIndex, offsetBy: 3))).`repeat`(2)
            alphaChannel += "ff"
            
            print("\(redChannel) - \(greenChannel) - \(blueChannel) - \(alphaChannel)")
            
        case 6 : // #123456 => #123456ff
            
            redChannel = css.substring(with: (css.startIndex ..< css.characters.index(css.startIndex, offsetBy: 2)))
            greenChannel = css.substring(with: (css.characters.index(css.startIndex, offsetBy: 2) ..< css.characters.index(css.startIndex, offsetBy: 4)))
            blueChannel = css.substring(with: (css.characters.index(css.startIndex, offsetBy: 4) ..< css.characters.index(css.startIndex, offsetBy: 6)))
            alphaChannel += "ff"
            
            
        case 8 : // #12345678 => #12345678
            
            redChannel += css.substring(with: (css.startIndex ..< css.characters.index(css.startIndex, offsetBy: 2)))
            greenChannel += css.substring(with: (css.characters.index(css.startIndex, offsetBy: 2) ..< css.characters.index(css.startIndex, offsetBy: 4)))
            blueChannel += css.substring(with: (css.characters.index(css.startIndex, offsetBy: 4) ..< css.characters.index(css.startIndex, offsetBy: 6)))
            alphaChannel += css.substring(with: (css.characters.index(css.startIndex, offsetBy: 6) ..< css.characters.index(css.startIndex, offsetBy: 8)))
            
        default :
            
            return UIColor.red
            
        }
        
        // Create hexadecimal number from the hexadecimal string
        Scanner(string: redChannel).scanHexInt32( &redChannelInt )
        Scanner(string: greenChannel).scanHexInt32( &greenChannelInt )
        Scanner(string: blueChannel).scanHexInt32( &blueChannelInt )
        Scanner(string: alphaChannel).scanHexInt32( &alphaChannelInt )
        
        return UIColor(red: CGFloat(redChannelInt) / 255, green: CGFloat(greenChannelInt) / 255, blue: CGFloat(blueChannelInt) / 255, alpha: CGFloat(alphaChannelInt) / 255)
        
    }
    
    /**
    Create an UIColor object based on a hexadecimal number
    
    - parameter hex:     The hexadecimal color string
    
    - returns: A new UIColor object
    */
    public class func colorWithHex( _ hex:UInt ) -> UIColor {
        
        var redChannel, greenChannel, blueChannel:CGFloat
        
        redChannel = CGFloat((hex >> 16) & 0xff) / 0xff
        greenChannel = CGFloat((hex >> 8) & 0xff) / 0xff
        blueChannel = CGFloat((hex >> 0) & 0xff) / 0xff
        
        return UIColor(red: redChannel, green: greenChannel, blue: blueChannel, alpha: 1.0)
        
    }
    
}
