//
//  BNActionSheetController.swift
//  AppUI
//
//  Created by Botirjon Nasridinov on 29/07/22.
//

import Foundation
import UIKit


public final class BNActionSheetController: UIViewController, BNActionSheetViewInstaller {
    
    internal var containerView: UIView!
    internal var containerViewTop: NSLayoutConstraint!
    internal var stackView: UIStackView!
    internal var stackViewTop: NSLayoutConstraint!
    internal var stackViewBottom: NSLayoutConstraint!
    
    var mainView: UIView { view }
    
    public override var modalTransitionStyle: UIModalTransitionStyle {
        didSet {
            super.modalTransitionStyle = .crossDissolve
        }
    }
    
    public override var modalPresentationStyle: UIModalPresentationStyle {
        didSet {
            super.modalPresentationStyle = .overFullScreen
        }
    }
    
    internal private(set) var regularActions: [BNAction] = []
    internal private(set) var cancelAction: BNAction?
    
    /// NOTE: - You can only set this property only once
    public var headerView: UIView? {
        didSet {
            if isViewLoaded {
                layoutActions()
            }
        }
    }
    
    private var didLayoutOnce: Bool = false
    private var isTransitioning: Bool = false
    private var viewDidLayout: Bool = false
    private var viewReadyForInteractions: Bool = false
    
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    private func initController() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        setupTargets()
        layoutActions()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isTransitioning = true
        if animated {
            self.showWhileAppearing {
                self.isTransitioning = false
                if self.viewDidLayout {
                    self.layoutOnce()
                }
                self.viewReadyForInteractions = true
            }
        }
        else {
            self.show(animated: animated, completion: {
                self.isTransitioning = false
                if self.viewDidLayout {
                    self.layoutOnce()
                }
                self.viewReadyForInteractions = true
            })
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !viewDidLayout {
            layoutOnce()
            viewDidLayout = true
        }
        stackViewTop?.constant = safeAreaInsets.top+20
        stackViewBottom?.constant = -safeAreaInsets.bottom
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func layoutOnce() {
        // TODO: - 
    }
    
    private func setupTargets() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(didTapView))
        tap.cancelsTouchesInView = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    public func addAction(_ action: BNAction) {
        switch action.style {
        case .cancel:
            self.cancelAction = action
        default:
            self.regularActions.append(action)
        }
        if isViewLoaded {
            layoutActions()
        }
    }
    
    func layoutActions() {
        guard stackView != nil else { return }
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview()
        }
        
        if !regularActions.isEmpty || headerView != nil {
            let regularActionsView = BNRegularActionsView(actions: self.regularActions, headerView: self.headerView)
            regularActionsView.didTapActionView = { (_) in
                self.close(completion: nil)
            }
            stackView.addArrangedSubview(regularActionsView)
        }
        
        if cancelAction != nil {
            let actionView = BNActionView()
            actionView.action = cancelAction
            actionView.layer.cornerRadius = contentCornerRadius
            actionView.clipsToBounds = true
            actionView.didTap = { self.close(completion: nil) }
            stackView.addArrangedSubview(actionView)
        }
        
        stackView.arrangedSubviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: $0.superview!.widthAnchor).isActive = true
        }
    }
    
    @objc private func didTapView() {
        self.close(completion: nil)
    }
}

internal extension BNActionSheetController {
    enum TableSection: Int, CaseIterable {
        case regularActions = 0
        case cancelAction
    }
}



