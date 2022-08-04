//
//  BNAction.swift
//  AppUI
//
//  Created by Botirjon Nasridinov on 29/07/22.
//

import Foundation
import UIKit

public struct BNAction {
    
    public typealias Handler = (BNAction) -> Void
    
    public var title: String
    public var style: Style
    public var handler: Handler?
    
    public init(title: String, style: Style, handler: Handler?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    
    public enum Style {
        case `default`
        case cancel(color: UIColor? = nil, font: UIFont? = nil)
        case destructive
        case custom(color: UIColor, font: UIFont)
        
        internal var color: UIColor {
            switch self {
            case .default:
                return .systemBlue
            case .cancel(let color, _):
                return color ?? .systemBlue
            case .destructive:
                return .systemRed
            case .custom(let color, _):
                return color
            }
        }
        
        internal var font: UIFont {
            switch self {
            case .default:
                return .systemFont(ofSize: 18)
            case .cancel(_, let font):
                return font ?? .systemFont(ofSize: 18)
            case .destructive:
                return .systemFont(ofSize: 18)
            case .custom(_, let font):
                return font
            }
        }
    }
}
