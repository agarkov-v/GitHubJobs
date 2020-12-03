//
//  JobsListHeaderCell.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

protocol JobsListHeaderCellView {
    func setupCell()
}

class JobsListHeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension JobsListHeaderCell: JobsListHeaderCellView {
    func setupCell() {
        
    }
}
