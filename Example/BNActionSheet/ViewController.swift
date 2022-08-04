//
//  ViewController.swift
//  BNActionSheet
//
//  Created by botirjon on 08/03/2022.
//  Copyright (c) 2022 botirjon. All rights reserved.
//

import UIKit
import BNActionSheet

fileprivate class HeaderView: UIStackView {
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        return titleLabel
    }()
    
    private(set) lazy var bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.font = .italicSystemFont(ofSize: 17)
        bodyLabel.setContentHuggingPriority(.required, for: .vertical)
        return bodyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        self.axis = .vertical
        self.distribution = .fill
        self.alignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(titleLabel)
        addArrangedSubview(bodyLabel)
        
        let constraints = arrangedSubviews.map { view in
            view.widthAnchor.constraint(equalTo: self.widthAnchor)
        }
        
        NSLayoutConstraint.activate(constraints)
    }
}


class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(didTapOpen), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func didTapOpen() {
        let actions: [BNAction] = (0..<50).map { i in
                .init(title: "Action \(i)", style: i % 2 == 0 ? .default : .destructive) { _ in
                    print("Did tap action!")
                }
        }
        
        let actionSheet = BNActionSheetController()
        actions.forEach { action in
            actionSheet.addAction(action)
        }
        
        actionSheet.addAction(.init(title: "Cancel", style: .cancel, handler: { _ in
            print("Did tap cancel action")
        }))
        
        let headerView = HeaderView()
        headerView.titleLabel.text = "Title"
        headerView.bodyLabel.text = "Body"
        actionSheet.headerView = headerView
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

