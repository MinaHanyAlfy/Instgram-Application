//
//  DatabaseManager.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 09/02/2022.
//

import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    public func canCreateNewUser(with email:String,username: String, compelation: @escaping (Bool) -> Void ){
        compelation(true)
        
    }
    public func insertNewUserDatabase(with email: String, username: String, compelation: @escaping (Bool) -> Void){
        
        database.child(email.safeDatabase()).setValue(["username":username]) { error, _ in
            if error  == nil{
                //Success
                compelation(true)
            }else {
                //Failure
                compelation(false)
            }
        }
        
    }
  
}
