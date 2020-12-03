//
//  BaseRouter.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

class StubLoad: UIView {
    
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.text = "Loading..."
        }
    }
    
    func show() {
        activityIndicator.startAnimating()
    }
    
}
