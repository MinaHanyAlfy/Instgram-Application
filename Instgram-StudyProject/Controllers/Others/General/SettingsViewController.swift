//
//  SettingsViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 09/02/2022.
//

import UIKit
import FirebaseAuth
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
        let section = [
            SettingsCellModel(title: "Logout", handler: { [weak self] in
                self?.didTapLogOut()
            })
        ]
        data.append(section)
        
    }
    
    private func didTapLogOut(){
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    
    
}
