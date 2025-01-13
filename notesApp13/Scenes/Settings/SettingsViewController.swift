//
//  SettingsViewController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 29.12.24.
//

import UIKit

class SettingsViewController: UIViewController {
    weak var authDelegate: AuthorisationDelegate?

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
        self.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.fill"),
            tag: 1
        )
    }
    private func setUpUI() {
        let buttonsNSectionsStack = UIStackView()
        buttonsNSectionsStack.axis = .vertical
        buttonsNSectionsStack.spacing = 32
        buttonsNSectionsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsNSectionsStack)
        
        let accountSection = setUpSettingsSection(title: "personal", buttons: [
            setUpSettingsButton(title: "personal info", icon: "person.fill"),
            setUpSettingsButton(title: "password and security", icon: "lock.fill")
        ])
        
        let uiSection = setUpSettingsSection(title: "ui", buttons: [
            setUpSettingsButton(title: "dark mode", icon: "moon.fill")
        ])
        
        let signOutButton = UIButton(configuration: .filled())
        signOutButton.configuration?.title = "Sign Out"
        signOutButton.configuration?.baseForegroundColor = .white
        signOutButton.configuration?.baseBackgroundColor = .systemRed
        signOutButton.configuration?.cornerStyle = .capsule
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        
        [accountSection, uiSection].forEach { buttonsNSectionsStack.addArrangedSubview($0) }
        view.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            buttonsNSectionsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            buttonsNSectionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsNSectionsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            signOutButton.topAnchor.constraint(equalTo: buttonsNSectionsStack.bottomAnchor, constant: 32),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    private func setUpSettingsSection(title: String, buttons: [UIButton])-> UIStackView {
        let sectionStack = UIStackView()
        sectionStack.axis = .vertical
        sectionStack.spacing = 16
        sectionStack.alignment = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        
        let buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.alignment = .fill
        buttonStack.spacing = 8
        
        buttons.forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.contentHorizontalAlignment = .leading
            buttonStack.addArrangedSubview(button)
        }
        [titleLabel, buttonStack].forEach { sectionStack.addArrangedSubview($0) }
        
        return sectionStack
    }
    private func setUpSettingsButton(title: String, icon: String) -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = UIImage(systemName: icon)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        configuration.baseForegroundColor = .gray
        
        let button = UIButton(configuration: configuration)
        button.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.baseForegroundColor = button.isHighlighted ? .red : .gray
            button.configuration = config
        }
        
        button.backgroundColor = .secondarySystemGroupedBackground
        button.layer.cornerRadius = 10
        return button
    }
    @objc private func signOutTapped(){
        UserAuthorization.shared.isAuthorized = false
        authDelegate?.didUpdateAuthentication()
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
