//
//  MainScreenAdminViewController.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import UIKit

class MainScreenAdminViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var user : User?
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "AdminTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        DatabaseManager.shared.getUserData { result in
            switch result {
            case .success(let userResponse) :
                self.users.append(contentsOf: userResponse)
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
        
    }
    
}

extension MainScreenAdminViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell
        let user = users[indexPath.row]
        cell.configure(user: user)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete :
            DatabaseManager.shared.deleteUser(user: users[indexPath.row]) { result in
                switch result {
                case .success() :
                    print("delete success")
                    self.users.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error) :
                    print(error)
                }
            }
        default :
            break
        }
    }
}


