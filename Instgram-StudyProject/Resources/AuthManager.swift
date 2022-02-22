//
//  AuthManager.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 09/02/2022.
//

import Foundation
import FirebaseAuth
import NVActivityIndicatorView
public class AuthManager{
    static let shared = AuthManager ()
  
    //MARK: - public
    public func registerNewUser(username: String, password: String, email: String, completion: @escaping (Bool) -> Void){
            
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            DispatchQueue.main.async {
                if canCreate {
                    //Here Can create  and insert into database.
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        guard error == nil , authResult != nil else{
                            //Firebase  Could not create account
                            completion(false)
                            
                            return
                        }
                        DatabaseManager.shared.insertNewUserDatabase(with: email, username: username){ inserted in
                            if inserted{
                                completion(true)
                                
                                return
                            }else {
                                 completion(false)
                                return
                            }
                        }
                        
                    }
                }else {
                    completion(false)
                    return
                }
            }
        }
    }
    
    public func loginUser(username: String?, password: String, email: String?, completion: @escaping (Bool) -> Void ){
        
        print(email, username)
        if let email = email {
            //  email login
            
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil,error == nil else{
                    completion(false)
                
                    return
                }
                completion(true)
                return
            }
        
        }else if let username = username {
            // username login
            print(username)

        }
        
        
    }
    
    
    public func logoutUser(compelation: (Bool) -> Void) {
        do{
            try Auth.auth().signOut()
            compelation(true)
            return
        }catch{
            compelation(false)
            print("Failed to logout")
            return
        }
        
    }
}
