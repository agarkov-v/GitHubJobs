//
//  BaseRouter.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

enum StubType {
    case noData
    case somethingWrong
    
    static func getImage(_ type: StubType) -> UIImage {
        switch type {
        case .noData: return R.image.noDataPlaceholder()!
        case .somethingWrong: return R.image.errorPlaceholder()!
        }
    }
    
    static func getTitle(_ type: StubType) -> String {
        switch type {
        case .noData: return "Wow!"
        case .somethingWrong: return "Oops!"
        }
    }
    
    static func getMessage(_ type: StubType) -> String {
        switch type {
        case .noData: return "There is no info yet"
        case .somethingWrong: return "Something went wrong"
        }
    }
}

class StubView: UIView {
    
    @IBOutlet weak var stubImage: UIImageView!
    @IBOutlet weak var stubTitle: UILabel!
    @IBOutlet weak var stubMessage: UILabel!
    
    func setup(_ image: UIImage, _ title: String, _ message: String) {
        let textColor = R.color.inactiveGray()!
        stubImage.image = image
        stubTitle.text = title
        stubMessage.text = message
        
        stubTitle.textColor = textColor
        stubMessage.textColor = textColor
        
        self.setNeedsDisplay()
        self.setNeedsLayout()
    }
    
    func setup(_ type: StubType) {
        let textColor = R.color.inactiveGray()!
        stubImage.image = StubType.getImage(type)
        stubTitle.text = StubType.getTitle(type)
        stubMessage.text = StubType.getMessage(type)
        
        stubTitle.textColor = textColor
        stubMessage.textColor = textColor
        
        self.setNeedsDisplay()
        self.setNeedsLayout()
    }
}
