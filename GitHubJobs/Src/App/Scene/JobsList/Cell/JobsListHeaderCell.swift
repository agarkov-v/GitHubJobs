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
        let now = Date()
        let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: now)
        let today = Calendar.current.date(from: todayComponents)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!

        let todayString = dateFormatterUtil.convertDateToString(date: today, format: "dd/MM/yyyy")
        let currentString = dateFormatterUtil.convertDateToString(date: date, format: "dd/MM/yyyy")
        let yesterdayString = dateFormatterUtil.convertDateToString(date: yesterday, format: "dd/MM/yyyy")

        if todayString == currentString {
            dateLabel.text = "Today"
        } else if yesterdayString == currentString {
            dateLabel.text = "Yesterday"
        } else {
            dateLabel.text = currentString
        }
    }
}
