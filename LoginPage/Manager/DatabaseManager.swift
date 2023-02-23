//
//  DatabaseManager.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    func signUp (username: String, password: String, email: String, role: String, completion: (Result<Void, Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let user = User(context: context)
        user.id = UUID()
        user.email = email
        user.username = username
        user.role = role
        user.password = password
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print("error")
            completion(.failure(error))
        }
    }
    
    func getUserData(completion: @escaping (Result<[User], Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User>
        request = User.fetchRequest()
        
        do {
            let users = try context.fetch(request)
            completion(.success(users))
        } catch {
            completion(.failure(error))
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User> = NSFetchRequest<User>(entityName: "User")
        
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let user = try context.fetch(request).first
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteUser(user: User, completion: (Result<Void, Error>) -> Void  ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(user)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
}
