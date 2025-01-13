//
//  TabBarController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 21.12.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    var userInTabBar: User?
    private lazy var noteListViewController: UIViewController = {
        let storyboard = UIStoryboard(name: "NoteList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NoteListID")
        viewController.tabBarItem = UITabBarItem(
            title: "Notes",
            image: UIImage(systemName: "note.text"),
            tag: 0
        )
        print(userInTabBar?.name ?? "nil")
        viewController.navigationItem.title = "\(userInTabBar?.name ?? "nil")'s Notes"
        return viewController
    }()
    
    private lazy var signInViewController: UIViewController = {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignInID") as! SignInViewController
        viewController.authDelegate = self
        viewController.userDelegate = self
        viewController.tabBarItem = UITabBarItem(
            title: "Sign In",
            image: UIImage(systemName: "person"),
            tag: 1
        )
        return viewController
    }()
    
    private lazy var pleaseSignInViewController: UIViewController = {
        let viewController = PleaseSignInViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Sign In Required",
            image: UIImage(systemName: "lock"),
            tag: 2
        )
        return viewController
    }()
    
    private lazy var settingsViewController: UIViewController = {
        let viewController = SettingsViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 3
        )
        viewController.authDelegate = self
        return viewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = .systemYellow
        updateTabBar()
    }
    @objc private func handleAuthorizationChange() {
        updateTabBar()
    }
    func updateTabBar() {
        DispatchQueue.main.async {
            
            if UserAuthorization.shared.isAuthorized {
                self.viewControllers = [self.noteListViewController, self.settingsViewController]
                print(self.userInTabBar?.name ?? "nil")
                if let navigationController = self.viewControllers?.first(where: { $0 is UINavigationController }) as? UINavigationController,
                   let noteListVC = navigationController.viewControllers.first(where: { $0 is NoteListViewController }) as? NoteListViewController {
                    noteListVC.title = "\(self.userInTabBar?.name ?? "nil")'s Notes"
                } else {
                    print("NoteListViewController is not found inside the Navigation Controller.")
                }
                //"\(self.userInTabBar?.name ?? "nil")'s Notes"
                
            } else {
                self.viewControllers = [self.pleaseSignInViewController, self.signInViewController]
            }
        }
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller: \(viewController)")
    }
}

//MARK: -Extension AuthorisationDelegate
extension TabBarController: AuthorisationDelegate {
    func didUpdateAuthentication() {
        updateTabBar()
    }
}
//MARK: -Extension UserDelegate
extension TabBarController: UserDelegate {
    func didreceiveUser(_ user: User) {
        self.userInTabBar = user
        print("received user \(userInTabBar?.name ?? "nil!!!")")
    }
}
