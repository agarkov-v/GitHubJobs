//
//  JobsListHeaderCell.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

protocol JobsListHeaderCellView {
    func setupCell(date: Date)
}

class JobsListHeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension JobsListHeaderCell: JobsListHeaderCellView {
    func setupCell(date: Date) {
        let dateString = DateFormatUtil.convertDateToString(date: date, format: "dd/MM/yyyy")
        dateLabel.text = dateString
    }
}
