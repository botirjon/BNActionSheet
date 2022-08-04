//
//  BNActionView.swift
//  AppUI
//
//  Created by Botirjon Nasridinov on 29/07/22.
//

import Foundation
import UIKit


internal final class BNActionView: UIControl, BNActionViewInstaller {
    
    internal var blurView: UIVisualEffectView!
    internal var titleLabel: UILabel!
    
    var mainView: UIView { self }
    
    static let preferredDefaultHeight: CGFloat = 58
    
    internal var action: BNAction? {
        didSet {
            _setupControl()
            invalidateIntrinsicContentSize()
        }
    }
    
    private var isTouching: Bool = false {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    var didTap: (() -> Void)?
    
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor == .clear {
                blurView?.isHidden = true
            } else {
                blurView?.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initControl()
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: super.intrinsicContentSize.width, height: _contentHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.frame = self.bounds
    }
    
    private func initControl() {
        installSubviews()
        setupTargets()
    }
    
    private func setupTargets() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(_didTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func _didTap() {
        if let action = action {
            self.action?.handler?(action)
        }
        didTap?()
    }
    
    static func contentHeight(title: String, font: UIFont, width: CGFloat) -> CGFloat {
        return max(titleHeight(title: title, font: font, width: width) + 2*17, preferredDefaultHeight)
    }
    
    static func titleHeight(title: String, font: UIFont, width: CGFloat) -> CGFloat {
        return title.height(withConstrainedWidth: width-2*16, font: font)
    }
    
    var titleColor: UIColor {
        return isTouching ? _titleColor.withAlphaComponent(0.5) : _titleColor
    }
    
    var titleFont: UIFont {
        style.font
    }
}



fileprivate extension BNActionView {
    
    private var style: BNAction.Style {
        return action?.style ?? .default
    }
    
    private func _setupControl() {
        titleLabel.textColor = titleColor
        titleLabel.text = action?.title
        addTarget(self, action: #selector(_didTap), for: .touchUpInside)
    }
    
    private var _contentHeight: CGFloat {
        return BNActionView.contentHeight(title: action?.title ?? "", font: titleLabel.font, width: self.bounds.size.width-2*16)
    }
    
    private var _titleHeight: CGFloat {
        return BNActionView.titleHeight(title: action?.title ?? "", font: titleLabel.font, width: self.bounds.size.width-2*16)
    }
    
    private var _titleColor: UIColor {
        style.color
//        switch style {
//        case .`default`, .cancel:
//            return UIColor(red: 0, green: 0.333, blue: 0.846, alpha: 1)
//        case .destructive:
//            return UIColor(red: 0.918, green: 0, blue: 0, alpha: 1)
//        }
    }
}




extension BNActionView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouching = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouching = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouching = false
    }
}
