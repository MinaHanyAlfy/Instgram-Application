//
//  EditProfileViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 09/02/2022.
//

import UIKit

struct EditProfileModel{
    let label: String
    let placeHolder: String
    var value: String?
}

class EditProfileViewController: UIViewController {
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.tableHeaderView = headerTableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Save",
                                                             style: .done,
                                                             target: self,
                                                             action: #selector(didTapSave))
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
        configureModels()
        // Do any additional setup after loading the view.
    }
    private var models = [[EditProfileModel]]()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        //name ,username, url, website, bio
        let section1Labels =  ["Name","Username","Bio"]
        var section1 = [EditProfileModel]()
        for label in section1Labels {
            let model = EditProfileModel(label: label, placeHolder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        //email, phone, gender
        var section2 = [EditProfileModel]()
        let section2Labels = ["Email","Phone","Gender"]
        for label in section2Labels {
            let model = EditProfileModel(label: label, placeHolder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    private func headerTableView () -> UIView{
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4.0).integral)
        let size = headerView.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2, y: (headerView.height-size)/2, width: size, height: size))
        
        headerView.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.addTarget(self, action: #selector(didTapChaneProfilePicture), for: .touchUpInside)
        profilePhotoButton.tintColor = .label
        profilePhotoButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.imageView?.contentMode = .scaleToFill
        profilePhotoButton.layer.borderWidth = 1.0
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor

        
        return headerView
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
extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier , for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configureCell(with: model)
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    
}
extension EditProfileViewController: FormTableViewCellDelegate{
    
    
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileModel) {
        print("New Data is : ", updateModel.value)
//        updateModel.value
    }
    
    
}
