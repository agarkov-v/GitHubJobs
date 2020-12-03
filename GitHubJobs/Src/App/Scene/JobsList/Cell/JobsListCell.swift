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
    
    @IBOutlet weak var vacancyLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var applyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTextView.textContainer.lineFragmentPadding = 0
    }

}

extension JobsListCell: JobsListCellView {
    
    func setupCell(vacancy: VacancyEntity) {
//        vacancyLabel.text = vacancy.title
//        companyNameLabel.text = vacancy.company
//        applyTextView.text = vacancy.howToApply
    }
}
