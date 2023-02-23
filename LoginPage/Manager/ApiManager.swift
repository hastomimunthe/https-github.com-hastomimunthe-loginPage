//
//  Caller.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    
    func getPhotos(start: Int, limit: Int ,completion: @escaping (Result<[Photo], Error>) -> Void ) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_start=\(start)&_limit=\(limit)") else { return }
        AF.request (url)
            .responseDecodable(of: [Photo].self) { response in
                switch response.result {
                case .success(let photos) :
                    completion(.success(photos))
                    print(photos.count)
                case .failure(let error) :
                    completion(.failure(error))
                }
            }
    }
    
}





