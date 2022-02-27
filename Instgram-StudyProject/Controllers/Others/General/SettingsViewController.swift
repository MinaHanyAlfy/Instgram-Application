//
//  SettingsViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 09/02/2022.
//

import UIKit
import FirebaseAuth
import SafariServices
struct SettingsCellModel{
    let title: String
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController {
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var  data = [[SettingsCellModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureModels()
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.backgroundColor = .systemBackground
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        
        data.append([
            SettingsCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.didTapEditProfile()
            })
            ,SettingsCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.didTapInviteFriends()
            })
            ,SettingsCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.didTapSaveOriginalPosts()
            })
            
        ])
        
        data.append([
            SettingsCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openUrl(type: .terms)
            }),
            SettingsCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openUrl(type: .privacy)
            }),
            SettingsCellModel(title: "Help / Feedback", handler: { [weak self] in
                self?.openUrl(type: .help)
            })
        ])
        
        data.append([
            SettingsCellModel(title: "Logout", handler: { [weak self] in
                self?.didTapLogOut()
            })
        ])
        
    }

    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.navigationItem.title = "Edit Profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        navigationController?.present(navVc, animated: true, completion: nil)
        
    }
    
    private func didTapInviteFriends(){
        //Share Sheet
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    
    enum SettingsUrlTypes{
        case privacy, help, terms
    }
    
    private func openUrl(type: SettingsUrlTypes){
        let urlString : String
        switch type {
        case .privacy:
            urlString = "https://help.instagram.com/155833707900388"
        case .help:
            urlString = "https://help.instagram.com"
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        }
        guard let url = URL(string: urlString) else {
            return
        }
    
       let vc = SFSafariViewController(url: url)
       present(vc, animated: true, completion: nil)
    }
    
  
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out ?!", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logoutUser { success in
                DispatchQueue.main.async {
                    if success {
                        let loginVc = LoginViewController()
                        loginVc.modalPresentationStyle = .fullScreen
                        self.present(loginVc, animated: true) {
                            self.navigationController?.popToRootViewController(animated: true)
                            self.tabBarController?.selectedIndex = 0
                        }
                        
                    }else{
                        print("Error to logout")
                        
                    }
                }
                
            }
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true, completion: nil)
    }
    
}
extension SettingsViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  data[indexPath.section][indexPath.row].title
        cell.accessoryType =  .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    
    
}
