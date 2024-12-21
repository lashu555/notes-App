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
    private lazy var PleaseSignInViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Notes",
            image: UIImage(systemName: "note"),
            tag: 0
        )
        viewController.view.backgroundColor = .systemBackground
        let label = UILabel()
        label.text = "Please sign in"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .medium)
        viewController.view.addSubview(label)

        let button = UIButton(configuration: .filled())
        button.setTitle("Go", for: .normal)
        button.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(button)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        ])
        return viewController
    }()
    var isAuthorised: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        isAuthorised = false
        self.delegate = self
        guard let authorised = isAuthorised else {
            return
        }
        if authorised{
            viewControllers = [noteListViewController, signInViewController]
        } else {
            viewControllers = [PleaseSignInViewController, signInViewController]
        }
        // Do any additional setup after loading the view.
    }
    @objc func goToSignIn(){
        self.selectedIndex = 1
    }
}
extension TabBarController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
