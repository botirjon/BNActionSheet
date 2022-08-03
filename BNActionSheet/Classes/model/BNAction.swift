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
        case cancel
        case destructive
    }
}
