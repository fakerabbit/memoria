//
//  Utils.swift
//  LucasBot
//
//  Created by Mirko Justiniano on 1/9/17.
//  Copyright © 2017 LB. All rights reserved.
//

import Foundation
import UIKit

struct Utils {
    
    /*
     * MARK:- FONTS
     */
    
    /*
     * Botdoh
     Botdoh
     
     * Nexa Light
     NexaLight
     
     * Nexa Bold
     NexaBold
     
     */
    
    static func printFontNamesInSystem() {
        for family in UIFont.familyNames {
            print("*", family);
            
            for name in UIFont.fontNames(forFamilyName: family ) {
                print(name);
            }
        }
    }
    
    static func logoFont() -> UIFont {
        return UIFont(name: "Botdoh", size: 30.0)!
    }
    
    static func mainFont() -> UIFont {
        return UIFont(name: "NexaLight", size: 18.0)!
    }
    
    static func boldFont() -> UIFont {
        return UIFont(name: "NexaBold", size: 18.0)!
    }
    
    static func buttonFont() -> UIFont {
        return UIFont(name: "NexaBold", size: 50.0)!
    }
    
    static func buttonSmallFont() -> UIFont {
        return UIFont(name: "NexaLight", size: 25.0)!
    }
    
    /*
     * MARK:- COLORS
     */
    
    static func backgroundColor() -> UIColor {
        return UIColor(colorLiteralRed: 96/255, green: 48/255, blue: 153/255, alpha: 1.0)
    }
    
    static func darkBackgroundColor() -> UIColor {
        return UIColor(colorLiteralRed: 39/255, green: 30/255, blue: 87/255, alpha: 1.0)
    }
    
    static func textColor() -> UIColor {
        return UIColor.white
    }
    
    static func cardColor() -> UIColor {
        return UIColor(colorLiteralRed: 187/255, green: 25/255, blue: 119/255, alpha: 1.0)
    }
    
    static func cardAlternateColor() -> UIColor {
        return UIColor(colorLiteralRed: 231/255, green: 73/255, blue: 208/255, alpha: 1.0)
    }
    
    static func yellowColor() -> UIColor {
        return UIColor(colorLiteralRed: 226/255, green: 208/255, blue: 105/255, alpha: 1.0)
    }
    
    static func creamColor() -> UIColor {
        return UIColor(colorLiteralRed: 255/255, green: 239/255, blue: 188/255, alpha: 1.0)
    }
    
    static func orangeColor() -> UIColor {
        return UIColor(colorLiteralRed: 219/255, green: 169/255, blue: 56/255, alpha: 1.0)
    }
    
    static func redShadowColor() -> UIColor {
        return UIColor(colorLiteralRed: 124/255, green: 8/255, blue: 26/255, alpha: 1.0)
    }
    
    static func blueShadowColor() -> UIColor {
        return UIColor(colorLiteralRed: 17/255, green: 15/255, blue: 116/255, alpha: 1.0)
    }
    
    static func darkColor() -> UIColor {
        return UIColor(colorLiteralRed: 28/255, green: 15/255, blue: 56/255, alpha: 1.0)
    }
    
    /*
     * MARK:- IMAGES
     */
    
    static let kDefaultGif:String   = "wave-chat"
    static let kSandwich:String     = "sandwich"
    static let kPopBg:String        = "popBg"
    
    /*
     * MARK:- VALUES
     */
    
    static var interBubbleSpace: CGFloat = 20.00
    static var menuItemHeight = "40"
    static var menuItemWidth = "200"
    static var galleryItemHeight = "200"
    static var galleryItemWidth = "200"
    
    /*
     * MARK:- UTILS
     */
    
    static func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
