//
//  Font+Modifier.swift
//  beschool
//
//  Created by Igor Squadra on 16/12/24.
//


import SwiftUI
import UIKit

enum BarlowFontWeight {
    case regular
    case medium
    case semibold
    case bold
    case black
    var fontName: String {
        switch self {
        case .regular: return "Barlow-Regular"
        case .medium: return "Barlow-Medium"
        case .semibold: return "Barlow-SemiBold"
        case .bold: return "Barlow-Bold"
        case .black: return "Barlow-Black"
        }
    }
}

enum BarlowCondensedFontWeight {
    case medium
    case semibold
    case bold
    case extrabold
    case black
    var fontName: String {
        switch self {
        case .medium: return "BarlowCondensed-Medium"
        case .semibold: return "BarlowCondensed-SemiBold"
        case .bold: return "BarlowCondensed-Bold"
        case .extrabold: return "BarlowCondensed-ExtraBold"
        case .black: return "BarlowCondensed-Black"
        }
    }
}

enum RubikFontWeight {
    case semibold
    var fontName: String {
        switch self {
        case .semibold: return "Rubik-SemiBold"
        }
    }
}

enum TextStyles: CGFloat {
    /// Font size: 31.0
    case largeTitle1Size = 31.0
    /// Font size:  28.0
    case largeTitle2Size = 28.0
    /// Font size:  24.0
    case largeTitle3Size = 24.0
    /// Font size: 23.0
    case title1Size = 23.0
    /// Font size: 22.0
    case title2Size = 22.0
    /// Font size: 18.0
    case title3Size = 18.0
    /// Font size: 16.0
    case bodySize = 16.0
    /// Font size: 15.0
    case subheadlineSize = 15.0
    /// Font size: 14.0
    case calloutSize = 14.0
    /// Font size: 13.0
    case footnoteSize = 12.0
}

extension Font {
    static func barlow(size: TextStyles, weight: BarlowFontWeight = .regular) -> Font {
        return Font.custom(weight.fontName, size: size.rawValue)
    }
    
    static func barlowCondensed(size: TextStyles, weight: BarlowCondensedFontWeight = .medium) -> Font {
        return Font.custom(weight.fontName, size: size.rawValue)
    }
    
    static func rubik(size: TextStyles, weight: RubikFontWeight = .semibold) -> Font {
        return Font.custom(weight.fontName, size: size.rawValue)
    }
}

extension UIFont {
    static func barlow(size: TextStyles, weight: BarlowFontWeight = .regular) -> UIFont {
        UIFont(name: weight.fontName, size: size.rawValue)!
    }
    
    static func barlowCondensed(size: TextStyles, weight: BarlowCondensedFontWeight = .medium) -> UIFont {
        UIFont(name: weight.fontName, size: size.rawValue)!
    }
}
