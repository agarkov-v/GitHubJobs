//
//  View+animation.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

extension UIView {
    
    func fadeIn(_ duration: TimeInterval = 0.2, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration,
                       animations: { self.alpha = 1 },
                       completion: { (_: Bool) in
                        if let complete = onCompletion { complete() }
                       }
        )
    }
    
    func fadeOut(_ duration: TimeInterval = 0.2, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       animations: { self.alpha = 0 },
                       completion: { (_: Bool) in
                        self.isHidden = true
                        if let complete = onCompletion { complete() }
                       }
        )
    }
}
