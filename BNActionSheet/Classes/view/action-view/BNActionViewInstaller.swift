//
//  BNActionViewInstaller.swift
//  BNActionSheet
//
//  Created by Botirjon Nasridinov on 03/08/22.
//

import UIKit

internal protocol BNActionViewInstaller: ViewInstaller {
    var blurView: UIVisualEffectView! { get set }
    var titleLabel: UILabel! { get set }
    var titleColor: UIColor { get }
    var titleFont: UIFont { get }
}


internal extension BNActionViewInstaller {
    func initSubviews() {
        
        blurView = UIVisualEffectView.init(effect: UIBlurEffect(style: .light))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.isUserInteractionEnabled = false
        
        titleLabel = UILabel()
        titleLabel.textColor = titleColor
        titleLabel.font = titleFont
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.isUserInteractionEnabled = false
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
    }
    
    func addSubviews() {
        mainView.addSubview(blurView)
        mainView.addSubview(titleLabel)
    }
    
    func addSubviewConstraints() {
        NSLayoutConstraint.activate([
//            blurView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
//            blurView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
//            blurView.leftAnchor.constraint(equalTo: self.mainView.leftAnchor),
//            blurView.rightAnchor.constraint(equalTo: self.mainView.rightAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.mainView.centerYAnchor),
            titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.mainView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.mainView.rightAnchor, constant: 16)
        ])
    }
}
