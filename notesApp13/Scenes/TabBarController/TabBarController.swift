//
//  TabBarController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 21.12.24.
//

import UIKit

class TabBarController: UITabBarController {
    private lazy var noteListViewController: UIViewController = {
        let storyboard = UIStoryboard(name: "NoteList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NoteListID")
        viewController.tabBarItem = UITabBarItem(
            title: "Notes",
            image: UIImage(systemName: "note"),
            tag: 0
        )
        return viewController
    }()
    private lazy var signInViewController: UIViewController = {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignInID")
        viewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "person"),
            tag: 1
        )
        return viewController
    }()

    private lazy var pleaseSignInViewController: UIViewController = {
       let viewController = UIViewController()
       viewController.tabBarItem = UITabBarItem(
           title: "Notes",
           image: UIImage(systemName: "note"),
           tag: 0
       )
       viewController.view.backgroundColor = .systemBackground

      
       let containerStack = UIStackView()
       containerStack.axis = .vertical
       containerStack.spacing = 24
       containerStack.alignment = .center
       containerStack.translatesAutoresizingMaskIntoConstraints = false
       viewController.view.addSubview(containerStack)


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
            containerStack.centerXAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.centerXAnchor),
            containerStack.centerYAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.centerYAnchor, constant: -40),
            containerStack.leadingAnchor.constraint(greaterThanOrEqualTo: viewController.view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            containerStack.trailingAnchor.constraint(lessThanOrEqualTo: viewController.view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])

       return viewController
    }()
    private lazy var settingsViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.fill"),
            tag: 1
        )
        viewController.view.backgroundColor = .systemGroupedBackground

        // Main stack view
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 32
        mainStack.alignment = .fill
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(mainStack)

        // Profile header
        let profileStack = createProfileHeader()

        // Settings sections
        let accountSection = createSettingsSection(
            title: "Account",
            buttons: [
                createSettingsButton(title: "Personal Information", subtitle: nil, icon: "person.fill"),
                createSettingsButton(title: "Password & Security", subtitle: nil, icon: "lock.fill"),
                createSettingsButton(title: "Notifications", subtitle: nil, icon: "bell.fill")
            ]
        )

        let preferencesSection = createSettingsSection(
            title: "Preferences",
            buttons: [
                createSettingsButton(title: "Appearance", subtitle: nil, icon: "paintbrush.fill"),
                createSettingsButton(title: "Language", subtitle: nil, icon: "globe"),
                createSettingsButton(title: "Privacy", subtitle: nil, icon: "hand.raised.fill")
            ]
        )

        // Sign-out button
        let signOutButton = UIButton(configuration: .filled())
        signOutButton.configuration?.title = "Sign Out"
        signOutButton.configuration?.baseForegroundColor = .white
        signOutButton.configuration?.baseBackgroundColor = .systemRed
        signOutButton.configuration?.cornerStyle = .capsule
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)

        // Add to main stack
        [profileStack, accountSection, preferencesSection, signOutButton].forEach { mainStack.addArrangedSubview($0) }

        // Constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16),
        ])

        return viewController
    }()
    var isAuthorised: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        isAuthorised = UserAuthorization.shared.isAuthorized
        self.delegate = self
        guard let authorised = isAuthorised else {
            return
        }
        if authorised{
            viewControllers = [noteListViewController, settingsViewController]
        } else {
            viewControllers = [pleaseSignInViewController, signInViewController]
        }
        // Do any additional setup after loading the view.
    }
    @objc func goToSignIn(){
        self.selectedIndex = 1
    }
    @objc func signOutTapped(){
        UserAuthorization.shared.isAuthorized = false
        self.viewDidLoad()
    }
}
extension TabBarController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
extension TabBarController{
    
    // Helper Functions
    private func createProfileHeader() -> UIStackView {
        let profileStack = UIStackView()
        profileStack.axis = .horizontal
        profileStack.spacing = 16
        profileStack.alignment = .center

        let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemBlue
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        let nameStack = UIStackView()
        nameStack.axis = .vertical
        nameStack.spacing = 4

        let nameLabel = UILabel()
        nameLabel.text = "John Doe"
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)

        let emailLabel = UILabel()
        emailLabel.text = "john.doe@example.com"
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.textColor = .secondaryLabel

        [nameLabel, emailLabel].forEach { nameStack.addArrangedSubview($0) }
        [profileImageView, nameStack].forEach { profileStack.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80)
        ])

        return profileStack
    }

    private func createSettingsSection(title: String, buttons: [UIButton]) -> UIStackView {
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

    private func createSettingsButton(title: String, subtitle: String?, icon: String) -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = UIImage(systemName: icon)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        configuration.baseForegroundColor = .label
        
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .secondarySystemGroupedBackground
        button.layer.cornerRadius = 10
        return button
    }

}
