//
//  ViewController.swift
//  BNActionSheet
//
//  Created by botirjon on 08/03/2022.
//  Copyright (c) 2022 botirjon. All rights reserved.
//

import UIKit
import BNActionSheet

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
        let actions: [BNAction] = (0..<4).map { i in
                .init(title: "Action \(i)", style: i % 2 == 0 ? .default : .destructive) { _ in
                    print("Did tap action!")
                }
        }
        
        let actionSheet = BNActionSheetController()
        actions.forEach { action in
            actionSheet.addAction(action)
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

