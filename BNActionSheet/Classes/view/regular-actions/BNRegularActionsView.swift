//
//  BNRegularActionsView.swift
//  AppUI
//
//  Created by Botirjon Nasridinov on 02/08/22.
//

import Foundation
import UIKit


internal class BNRegularActionsView: UIScrollView, BNRegularActionsViewInstaller {
    
    var blurView: UIVisualEffectView!
    
    var stackView: UIStackView!
    
    var mainView: UIView { self }
    
    var didTapActionView: ((BNAction) -> Void)?
    
    private(set) var headerView: UIView? {
        didSet {
            self.invalidateIntrinsicContentSize()
            layoutActions()
        }
    }
    
    private(set) var actions: [BNAction] = [] {
        didSet {
            self.invalidateIntrinsicContentSize()
            layoutActions()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    convenience init(actions: [BNAction], headerView: UIView? = nil) {
        self.init(frame: .zero)
        self.actions = actions
        self.headerView = headerView
        initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.frame = self.bounds
        updateContentSize()
        invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: super.intrinsicContentSize.width, height: stackView.bounds.size.height)
    }
    
    private func initView() {
        installSubviews()
        setupTargets()
        layoutActions()
    }
    
    private func setupTargets() {
        
    }
    
    private func updateContentSize() {
        contentSize.height = stackView.bounds.size.height
    }
    
    private func layoutActions() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if headerView != nil {
            stackView.addArrangedSubview(headerView!)
            if actions.count > 0 {
                let separator = createSeparator()
                stackView.addArrangedSubview(separator)
            }
        }
        
        actions.enumerated().forEach { index, action in
            let actionView = BNActionView()
            actionView.action = action
            actionView.translatesAutoresizingMaskIntoConstraints = false
            actionView.backgroundColor = .clear
            actionView.didTap = { self.didTapActionView?(action) }
            stackView.addArrangedSubview(actionView)
            if index < max(0, actions.count-1) {
                let separator = self.createSeparator()
                stackView.addArrangedSubview(separator)
            }
        }
        
        stackView.arrangedSubviews.forEach { $0.widthAnchor.constraint(equalTo: $0.superview!.widthAnchor).isActive = true
        }
        
        updateContentSize()
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.init(red: 217/255, green: 220/255, blue: 231/255, alpha: 1)
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
}



internal extension BNRegularActionsView {
    func setActions(_ actions: [BNAction]) {
        self.actions = actions
    }
    
    func setHeaderView(_ headerView: UIView?) {
        self.headerView = headerView
    }
    
    func height() -> CGFloat {
        var height = actions.reduce(0) { partialResult, action in
            return partialResult + BNActionView.contentHeight(title: action.title, width: UIScreen.main.bounds.size.width-2*8)
        }
        
        height += (headerView?.frame.size.height ?? headerView?.intrinsicContentSize.height ?? 0)
        
        return height
    }
}
