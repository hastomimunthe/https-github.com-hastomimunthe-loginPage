//
//  LoginViewController.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var paswordLogin: UITextField!
    @IBOutlet weak var loginPage: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func goToMainPage(user: User?) {
        guard let user = user else {return}
        if user.role == "Admin" {
            let destination = MainScreenAdminViewController()
            destination.user = user
            navigationController?.pushViewController(destination, animated: true)
        } else {
            let destination = MainScreenUserViewController()
            destination.user = user
            navigationController?.pushViewController(destination, animated: true)
        }

    }

    func goToSignUp() {
        let destination = SignUpViewController()
        navigationController?.pushViewController(destination, animated: true)
    }

    func showAlert(title: String, message: String, action: String, handler: ((UIAlertAction) -> Void)? = nil) {
        guard presentedViewController == nil else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: handler))

        present(alert, animated: true)
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        guard let email = emailLogin.text,
              let password = paswordLogin.text else {return}
        
        DatabaseManager.shared.loginUser(email: email, password: password) { [self] result in
            switch result {
            case .success(let user) :
                if user != nil {
                    self.goToMainPage(user: user)
                } else {
                    showAlert(title: "Failed", message: "Your account not found, please Sign Up", action: "Okay")
                    print ("User tidak terdaftar")
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func buttonSignUp(_ sender: Any) {
        goToSignUp()
    }
    
}
