//
//  BNActionSheetViewInstaller.swift
//  BNActionSheet
//
//  Created by Botirjon Nasridinov on 03/08/22.
//

import UIKit

internal protocol BNActionSheetViewInstaller: ViewInstaller {
    var containerView: UIView! { get set }
    var containerViewTop: NSLayoutConstraint! { get set }
    var stackView: UIStackView! { get set }
    var stackViewBottom: NSLayoutConstraint! { get set }
    var stackViewTop: NSLayoutConstraint! { get set }
}

extension BNActionSheetViewInstaller {
    
    func initSubviews() {
        mainView.backgroundColor = .clear
        
        containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
        mainView.addSubview(containerView)
        containerView.addSubview(stackView)
    }
    
    func addSubviewConstraints() {
        
        containerViewTop = containerView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: UIScreen.main.bounds.size.height)
        
        stackViewBottom = stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        stackViewTop = stackView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor)
        
        NSLayoutConstraint.activate([
            
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height),
            containerViewTop,
            
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width-contentEdgeInsets.left-contentEdgeInsets.right),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackViewTop,
            stackViewBottom
        ])
    }
}


internal extension BNActionSheetViewInstaller {
    var contentEdgeInsets: UIEdgeInsets {
        .init(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    var contentCornerRadius: CGFloat {
        8
    }
}
