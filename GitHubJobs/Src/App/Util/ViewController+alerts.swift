//
//  ViewController+alerts.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String? = nil, firstActionTitle: String? = nil, secondActionTitle: String? = nil, firstCompletion: (() -> Void)? = nil, secondCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { (_) in
                secondCompletion?()
            }
            alertController.addAction(secondAction)
        }
        
        let firstAction = UIAlertAction(title: firstActionTitle ?? "Ok", style: .default) { (_) in
            firstCompletion?()
        }
        alertController.addAction(firstAction)
        self.present(alertController, animated: true)
    }
    
    func showActionSheetAlert(title: String? = nil, message: String? = nil, firstActionTitle: String? = nil, secondActionTitle: String? = nil, thirdActionTitle: String? = nil, firstCompletion: (() -> Void)? = nil, secondCompletion: (() -> Void)? = nil, thirdCompletion: (() -> Void)? = nil, fourthActionTitle: String? = nil, fourthCompletion: (() -> Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: firstActionTitle ?? "Ok", style: .default) { (_) in
            firstCompletion?()
        }
        alertController.addAction(firstAction)
        
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { (_) in
                secondCompletion?()
            }
            alertController.addAction(secondAction)
        }
        
        if let thirdActionTitle = thirdActionTitle {
            let thirdAction = UIAlertAction(title: thirdActionTitle, style: .default) { (_) in
                thirdCompletion?()
            }
            alertController.addAction(thirdAction)
        }
        
        if let fourthActionTitle = fourthActionTitle {
            let fourthAction = UIAlertAction(title: fourthActionTitle, style: .default) { (_) in
                fourthCompletion?()
            }
            alertController.addAction(fourthAction)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            cancelCompletion?()
        }))
        
        self.present(alertController, animated: true)
    }
    
    func showTimingAlert(message: String?) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        present(alertController, animated: true, completion: {
            _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
                alertController.dismiss(animated: true, completion: nil)
            })
        })
    }
}


