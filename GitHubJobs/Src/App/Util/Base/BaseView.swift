//
//  BaseView.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

typealias ActionChoiceDialog = (title: String, action: () -> Void)

protocol BaseView: class {
}

extension BaseView {
    
    func showErrorDialog(message: String,
                         action: ((UIAlertAction) -> Void)? = nil,
                         onShow: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Continue",
                                         style: .default,
                                         handler: action)
            alert.addAction(okAction)
            (self as? UIViewController)?.present(alert, animated: true, completion: onShow)
        }
    }
    
}

