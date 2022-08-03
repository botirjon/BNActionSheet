//
//  UIEdgeInsets+Ext.swift
//  BNActionSheet
//
//  Created by Botirjon Nasridinov on 02/08/22.
//

import UIKit

internal extension UIEdgeInsets {
    static var tableViewCellHiddenSeparatorInset: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.size.width)
    }
}
