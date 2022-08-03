//
//  BNActionSheetController+Presentation.swift
//  BNActionSheet
//
//  Created by Botirjon Nasridinov on 03/08/22.
//

import Foundation
import UIKit
import AudioToolbox

extension BNActionSheetController {
    
    public func close(completion: (() -> Void)? = nil) {
        hide(animated: true) {
            self.dismiss(animated: false, completion: {
                completion?()
            })
        }
    }
    
    
    func showWhileAppearing(completion: (() -> Void)? = nil) {
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            if context.presentationStyle == .overFullScreen && self.isBeingPresented {
                DispatchQueue.main.async {
                    AudioServicesPlaySystemSound(1520) //  `pop` feedback sound
                    self.show(animated: true)
                }
            }
        }, completion: { (_) in
            completion?()
        })
    }
    
    func show(animated: Bool = false, completion: (() -> Void)? = nil) {
        containerViewTop?.constant = 0
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.54)
                self.view.layoutIfNeeded()
            }) { (_) in
                completion?()
            }
        }
        else {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.54)
            completion?()
        }
    }
    
    func hide(animated: Bool = false, completion: (() -> Void)? = nil) {
        containerViewTop?.constant = UIScreen.main.bounds.size.height
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }) { (_) in
                completion?()
            }
        }
        else {
            self.view.backgroundColor = .clear
            completion?()
        }
    }
}

