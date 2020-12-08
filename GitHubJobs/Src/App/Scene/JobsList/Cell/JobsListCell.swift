//
//  JobsListCell.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

protocol JobsListCellView {
    func setupCell(vacancy: VacancyModel)
}

class JobsListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundVacancyView: UIView!
    @IBOutlet weak var vacancyLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var applyTextView: UITextView!
    
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
}

extension JobsListCell: JobsListCellView {
    
    func setupCell(vacancy: VacancyModel) {
        vacancyLabel.text = vacancy.title
        companyNameLabel.text = vacancy.company
        applyTextView.text = vacancy.howToApply
    }
}
