//
//  SignInViewController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 21.12.24.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    weak var authDelegate: AuthorisationDelegate?
    weak var userDelegate: UserDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = "lashu"
        emailTextField.text = "lashu@icloud.com"
        passwordTextField.text = "meowMeow"
        self.tabBarItem = UITabBarItem(
            title: "sign in",
            image: UIImage(systemName: "person.fill"),
            tag: 1
        )
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLogIn(_ sender: Any) {
        guard let inputEmail = emailTextField.text, !inputEmail.isEmpty,
              let inputPassword = passwordTextField.text, !inputPassword.isEmpty,
              let inputName = nameTextField.text, !inputName.isEmpty
        else {
            return
        }
        let maybeUser = User(name: inputName, email: inputEmail, password: inputPassword)
        if UserDataSource.shared.users.contains(where: { maybeUser == $0 }) {
            print("found user!")
            UserAuthorization.shared.isAuthorized = true
            authDelegate?.didUpdateAuthentication()
            userDelegate?.didreceiveUser(maybeUser)
        }
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


