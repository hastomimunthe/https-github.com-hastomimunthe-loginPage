//
//  MainScreenUserViewController.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import UIKit

class MainScreenUserViewController: UIViewController {

    var user : User? 
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    var isLoading = false
    var start = 0 {
        didSet {
            getPhotos(start: self.start, limit: self.limit)
        }
    }
    var limit = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        tableView.register(UINib(nibName: "UIMainTableViewCell", bundle: nil), forCellReuseIdentifier: "UIMainTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        getPhotos(start: self.start, limit: self.limit)
    }
    
    func getPhotos(start: Int, limit: Int) {
        isLoading = true
        ApiManager.shared.getPhotos (start: start, limit: limit ){ result in
            switch result {
            case .success(let photoResponse) :
                self.photos.append(contentsOf: photoResponse)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.isLoading = false
            case .failure(let error) :
                print(error.localizedDescription)
                self.isLoading = false
            }
        }
    }

}

extension MainScreenUserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UIMainTableViewCell", for: indexPath) as! UIMainTableViewCell
        let photo = photos[indexPath.row]
        cell.configure(photo: photo)
        
        return cell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (self.tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            print("FetchMore")
            if !isLoading {
                start = start + limit
            }
        }
    }
}
