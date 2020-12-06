//
//  BaseRouter.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

class StubLoadViewController: UIViewController {
    
    private var stubBackgroundView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    private var messageLabel = UILabel()
    private var backgroundColor: UIColor?
    private var closeView = UIView()
    private var closeLabel = UILabel()
    private var closeImageView = UIImageView()
    
//    convenience init() {
//        fatalError("init() has not been implemented")
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(backgroundColor: UIColor = .clear) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.closeView.fadeIn(1) {
                self.addGesture()
            }
//            self.closeView.fadeIn(1)
//            self.addGesture()
        }
    }
    
    private func prepareView() {
        self.view.backgroundColor = backgroundColor
        stubBackgroundView.layer.cornerRadius = 8
        stubBackgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        stubBackgroundView.isUserInteractionEnabled = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .white
        messageLabel.textColor = R.color.inactiveGrayColor()
        messageLabel.text = "Loading..."
        
        closeView.backgroundColor = .clear
        closeView.alpha = 0
        closeLabel.text = "Tap on screen to close"
        closeLabel.textColor = .white
        closeLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        closeLabel.numberOfLines = 2
        closeLabel.textAlignment = .center
        closeLabel.font = .systemFont(ofSize: 20, weight: .bold)
        closeImageView.image = R.image.closeIcon()
        closeImageView.tintColor = .white
    }
    
    private func configureConstraints() {
        stubBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stubBackgroundView)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        stubBackgroundView.addSubview(activityIndicator)
        stubBackgroundView.addSubview(messageLabel)
        
        closeView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeView)
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        closeView.addSubview(closeLabel)
        closeImageView.translatesAutoresizingMaskIntoConstraints = false
        closeView.addSubview(closeImageView)
        
        stubBackgroundView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        stubBackgroundView.widthAnchor.constraint(equalTo: stubBackgroundView.heightAnchor, multiplier: 1 / 1).isActive = true
        stubBackgroundView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stubBackgroundView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stubBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 11).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: stubBackgroundView.centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: stubBackgroundView.topAnchor, constant: 11).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: 5).isActive = true
        
        messageLabel.centerXAnchor.constraint(equalTo: stubBackgroundView.centerXAnchor).isActive = true

        closeView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        closeView.widthAnchor.constraint(equalTo: closeView.heightAnchor, multiplier: 1 / 1).isActive = true
        closeView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        closeView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        closeLabel.topAnchor.constraint(equalTo: closeView.topAnchor).isActive = true
        closeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20).isActive = true
        closeLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20).isActive = true
        closeLabel.centerXAnchor.constraint(equalTo: closeView.centerXAnchor).isActive = true
        
        closeImageView.centerXAnchor.constraint(equalTo: closeView.centerXAnchor).isActive = true
        closeImageView.centerYAnchor.constraint(equalTo: closeView.centerYAnchor).isActive = true
        closeImageView.heightAnchor.constraint(equalTo: closeImageView.widthAnchor, multiplier: 1 / 1).isActive = true
        closeImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

    func addGesture() {
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        self.view.addGestureRecognizer(closeTap)
    }
    
    @objc func onViewTap() {
        self.dismiss(animated: false)
    }

}
