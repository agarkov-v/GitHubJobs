//
//  JobsListCell.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

protocol JobsListCellView {
    func setupCell(vacancy: VacancyEntity)
}

class JobsListCell: UITableViewCell {
    
    @IBOutlet weak var backgroundVacancyView: UIView!
    @IBOutlet weak var vacancyLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var applyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareView()
    }
    
    private func prepareView() {
        let radius: CGFloat = 6
        backgroundVacancyView.layer.cornerRadius = radius
        applyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        applyTextView.textContainer.lineFragmentPadding = 0
    }
    
    func checkForUrls(text: String) -> [URL] {
        let types: NSTextCheckingResult.CheckingType = .link

        do {
            let detector = try NSDataDetector(types: types.rawValue)

            let matches = detector.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, text.count))
        
            let urls = matches.compactMap({ $0.url })
            debugPrint("checkForUrls url: \(urls)")
            return urls
        } catch let error {
            debugPrint("checkForUrls error \(error) || \(error.localizedDescription)")
        }

        return []
    }

}

extension JobsListCell: JobsListCellView {
    
    func setupCell(vacancy: VacancyEntity) {
        vacancyLabel.text = vacancy.title ?? "The job title is not specified"
        companyNameLabel.text = vacancy.company ?? "Company name not specified"
        applyTextView.text = vacancy.howToApply ?? "How to apply not specified"
        
//        if !(checkForUrls(text: vacancy.howToApply ?? "")).isEmpty {
//            let url = checkForUrls(text: vacancy.howToApply!)[0]
//            let attributedString = NSMutableAttributedString(string: vacancy.howToApply!)
//            attributedString.setAttributes([.link: url], range: NSMakeRange(0, vacancy.howToApply!.count))
//            applyTextView.attributedText = attributedString
//
//            applyTextView.isUserInteractionEnabled = true
//            applyTextView.isEditable = false
//
//            applyTextView.linkTextAttributes = [
//                .foregroundColor: UIColor.blue,
//                .underlineStyle: NSUnderlineStyle.single.rawValue
//            ]
//        } else {
//            applyTextView.text = vacancy.howToApply
//        }
        
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
    }
}
