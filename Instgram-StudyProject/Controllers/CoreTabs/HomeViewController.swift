//
//  ViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 06/02/2022.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    handleNotAuthenticated()
    
    }
    
    private func handleNotAuthenticated(){
        //MARK: - check auth status..
        if Auth.auth().currentUser == nil {
            // Show Login..
            
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: true, completion: nil)
            
        }else{
            print(Auth.auth().currentUser , Auth.auth().currentUser?.displayName.)
        }
        
    }
}

