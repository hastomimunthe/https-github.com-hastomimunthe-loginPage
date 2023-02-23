//
//  SignUpViewController.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var buttonAdmin: UIButton!
    @IBOutlet weak var buttonUser: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        buttonAdmin.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        buttonAdmin.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        buttonUser.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        buttonUser.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        
    }
    
    func gotoLoginPage() {
        let destination = LoginViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
    @IBAction func slctedButton(_ sender: UIButton) {
        if sender == buttonAdmin{
            buttonAdmin.isSelected = true
            buttonUser.isSelected = false
        } else {
            buttonAdmin.isSelected = false
            buttonUser.isSelected = true
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        gotoLoginPage()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let username = userName.text,
              let email = emailText.text,
              let password = passwordText.text else { return }
        
        if buttonAdmin.isSelected{
            DatabaseManager.shared.signUp(username: username, password: password, email: email, role: "Admin") {result in
                switch (result) {
                case.success() :
                    gotoLoginPage()
                case.failure(let error) :
                    print(error.localizedDescription)
                }
            }
        } else if (buttonUser.isSelected){
            DatabaseManager.shared.signUp(username: username, password: password, email: email, role: "User") {result in
                switch (result) {
                case.success() :
                    gotoLoginPage()
                case.failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
        DatabaseManager.shared.getUserData { result in
            switch (result) {
            case.success(let users) :
                print(users)
            case.failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    
}
