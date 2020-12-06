//
//  JobsListHeaderCell.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

protocol JobsListHeaderCellView {
    func setupCell(date: Date, dateFormatterUtil: DateFormatterUtil)
}

class JobsListHeaderCell: UITableViewHeaderFooterView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
}

extension JobsListHeaderCell: JobsListHeaderCellView {
    func setupCell(date: Date, dateFormatterUtil: DateFormatterUtil) {
        let dateString = dateFormatterUtil.convertDateToString(date: date, format: "dd/MM/yyyy")
        dateLabel.text = dateString
    }
}
