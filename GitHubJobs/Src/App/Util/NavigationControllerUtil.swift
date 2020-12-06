//
//  NavigationControllerUtil.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

extension UINavigationController {
    
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        
        self.popViewController(animated: animated)
        self.transitionCoordinator?.animate(alongsideTransition: nil) { _ in
            completion()
        }
    }
}
