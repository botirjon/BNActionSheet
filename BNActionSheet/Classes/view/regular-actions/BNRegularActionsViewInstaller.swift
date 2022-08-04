//
//  BNRegularActionsViewInstaller.swift
//  BNActionSheet
//
//  Created by Botirjon Nasridinov on 03/08/22.
//

import UIKit

internal protocol BNRegularActionsViewInstaller: ViewInstaller {
    var stackView: UIStackView! { get set }
    var blurView: UIVisualEffectView! { get set }
}


internal extension BNRegularActionsViewInstaller {
    func initSubviews() {
        let effect = UIBlurEffect.init(style: .light)
        blurView = UIVisualEffectView.init(effect: effect)
        
        if let scrollView = mainView as? UIScrollView {
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            scrollView.layer.cornerRadius = 10
        }
        
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
        mainView.addSubview(blurView)
        mainView.addSubview(stackView)
    }
    
    func addSubviewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ])
    }
}
