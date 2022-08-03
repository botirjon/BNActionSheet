//
//  BNRegularActionsViewInstaller.swift
//  BNActionSheet
//
//  Created by Botirjon Nasridinov on 03/08/22.
//

import UIKit

internal protocol BNRegularActionsViewInstaller: ViewInstaller {
    var stackView: UIStackView! { get set }
}


internal extension BNRegularActionsViewInstaller {
    func initSubviews() {
        if let scrollView = mainView as? UIScrollView {
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
//            scrollView.backgroundColor = UIColor.white
            scrollView.layer.cornerRadius = 10
        }
        
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
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
