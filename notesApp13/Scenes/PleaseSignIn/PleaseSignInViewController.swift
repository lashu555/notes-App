//
//  PleaseSignInViewController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 29.12.24.
//

import UIKit

class PleaseSignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        // Do any additional setup after loading the view.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpTabBar()
    }
    private func setUpTabBar(){
        view.backgroundColor = .systemBackground
    }
    private func setUpUI(){
        let containerStack = UIStackView()
        containerStack.axis = .vertical
        containerStack.spacing = 24
        containerStack.alignment = .center
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStack)
        
        
        let iconView = UIImageView()
        iconView.image = UIImage(systemName: "lock.shield")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 60, weight: .light)
        )
        iconView.tintColor = .systemBlue
        iconView.contentMode = .scaleAspectFit
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Sign in to Notes"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Access and manage all your notes"
        subtitleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        
        let signInButton = UIButton(configuration: .filled())
        signInButton.configuration?.cornerStyle = .large
        signInButton.configuration?.baseBackgroundColor = .systemBlue
        signInButton.configuration?.baseForegroundColor = .white
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.cornerStyle = .capsule
        buttonConfig.baseBackgroundColor = .systemBlue
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 48, bottom: 16, trailing: 48)
        signInButton.configuration = buttonConfig
        
        containerStack.addArrangedSubview(iconView)
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(subtitleLabel)
        containerStack.addArrangedSubview(signInButton)
        
        
        NSLayoutConstraint.activate([
            containerStack.centerXAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            containerStack.centerYAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -40),
            containerStack.leadingAnchor
                .constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            containerStack.trailingAnchor
                .constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
        
    }
    @objc private func goToSignIn(){
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
