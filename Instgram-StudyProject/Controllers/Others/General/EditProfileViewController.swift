//
//  EditProfileViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 09/02/2022.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Save",
                                                             style: .done,
                                                             target: self,
                                                             action: #selector(didTapSave))
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapSave(){
        
    }
    
    @objc private func didTapCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapChaneProfilePicture(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Picture", style: .default, handler: { action in
            //
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { action in
                //
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        //For ipad Issuse
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
}
