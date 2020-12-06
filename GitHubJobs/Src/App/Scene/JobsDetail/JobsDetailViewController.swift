//
//  JobsDetailViewController.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

class JobsDetailViewController: UIViewController {

    @IBOutlet weak var vacancyLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var vacancyDateLabel: UILabel!
    @IBOutlet weak var applyTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var presenter: JobsDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    func prepareView() {
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        descriptionTextView.textContainer.lineFragmentPadding = 0
        applyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        applyTextView.textContainer.lineFragmentPadding = 0
    }
    

}

extension JobsDetailViewController: JobsDetailView {
    
    func setupView(_ vacancy: VacancyEntity) {
        self.navigationItem.title = vacancy.title ?? "Vacancy"
        vacancyLabel.text = vacancy.title ?? "The job title is not specified"
        companyNameLabel.text = vacancy.company ?? "Company name not specified"
        
        let vacancyDate = vacancy.createdAt ?? ""
        let dateString = vacancyDate.replacingOccurrences(of: " UTC", with: "")
        let dateFormatter = DateFormatUtil.convertDateFormatToString(dateString: dateString, fromFormat: "EEE MMM d HH:mm:ss yyyy", toFotmat: "dd/MM/yyyy")

        vacancyDateLabel.text = dateFormatter ?? "Сreation date not specified"

        applyTextView.text = vacancy.howToApply ?? "How to apply not specified"
        descriptionTextView.text = vacancy.description ?? "Desctiption not specified"
    }
}
