//
//  CustomNavigationController.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 04.12.2020.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        item.tintColor = R.color.appBlueColor()!
        viewController.navigationItem.backBarButtonItem = item
    }
}
