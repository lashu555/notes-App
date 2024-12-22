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
    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "lashu@icloud.com"
        passwordTextField.text = "meowMeow"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLogIn(_ sender: Any) {
        guard let inputEmail = emailTextField.text, !inputEmail.isEmpty,
        let inputPassword = passwordTextField.text, !inputPassword.isEmpty
        else {
            return
        }
        let maybeUser = User(name: "", email: inputEmail, password: inputPassword)
        if UserDataSource.shared.users.contains(where: { maybeUser == $0 }) {
            UserAuthorization.shared.isAuthorized = true
            tabBarController?.viewDidLoad()
            tabBarController?.selectedIndex = 0
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
