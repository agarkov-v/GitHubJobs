//
//  JobsDetailViewController.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

class JobsDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var vacancyLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var vacancyDateLabel: UILabel!
    @IBOutlet weak var applyTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Public Properties
    var presenter: JobsDetailPresenter!
    var dateFormatterUtil: DateFormatterUtil!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    // MARK: - Private Methods
    private func prepareView() {
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        descriptionTextView.textContainer.lineFragmentPadding = 0
        applyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        applyTextView.textContainer.lineFragmentPadding = 0
    }
}

extension JobsDetailViewController: JobsDetailView {
    
    func setupView(_ vacancy: VacancyModel) {
        self.navigationItem.title = vacancy.title
        vacancyLabel.text = vacancy.title
        companyNameLabel.text = vacancy.company
        
        let dateFormatter = dateFormatterUtil.convertDateFormatToString(dateString: vacancy.createdAt, fromFormat: "EEE MMM d HH:mm:ss yyyy", toFotmat: "dd/MM/yyyy")
        vacancyDateLabel.text = dateFormatter
        
        applyTextView.text = vacancy.howToApply
        descriptionTextView.text = vacancy.description
    }
}
