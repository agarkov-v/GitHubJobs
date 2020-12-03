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
        descriptionTextView.textContainer.lineFragmentPadding = 0
        applyTextView.textContainer.lineFragmentPadding = 0
    }
    

}

extension JobsDetailViewController: JobsDetailView {
    
    func setupView(_ vacancy: VacancyEntity) {
//        self.navigationController?.navigationBar.topItem?.title = vacancy.title
//        vacancyLabel.text = vacancy.title
//        companyNameLabel.text = vacancy.company
//        applyTextView.text = vacancy.howToApply
//        descriptionTextView.text = vacancy.description
    }
}
