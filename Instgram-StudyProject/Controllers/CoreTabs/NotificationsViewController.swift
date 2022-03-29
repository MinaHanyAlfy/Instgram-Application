//
//  NotificationsViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 06/02/2022.
//

import UIKit
    
class NotificationsViewController: UIViewController {
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.isUserInteractionEnabled = true
        return  tableView
    }()
    private var models = [UserNotification]()
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    private lazy var noNotificationView = NoNotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notification"
//        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(spinner)
//        spinner.startAnimating()
       
        tableView.delegate = self
        tableView.dataSource = self
        fetchNotification()
        
    }
    
    private func fetchNotification(){
        for x in 0...100{
            let user = User(name: (firstname: "", lastname: ""), birthdate: Date(), gender: .male, bio: "Hello", counts: UserCount(followers: 10, following: 10, posts: 10), joinDate: Date(), profilePic: URL(string: "https://www.google.com")!)

            let post = UserPost(identifier: "", postUserType: .photo, thumbnailImage: URL(string:"https://www.google.com")!, postUrl: URL(string:"https://www.google.com")!, caption: nil, likeCount: [], comments: [], createDate: Date(), userTagged: [],owner: user )
            
            let model = UserNotification(user: user ,text: x % 2 == 0 ? "@Mina Hany Liked Your post." : "@RamyMicheal has follow you.", type: x % 2 == 0 ? .like(post: post) : .follow(state: .notFollowing))
            
            models.append(model)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
        
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
//        noNotificationViewLayout()
    }
    private func noNotificationViewLayout(){
        tableView.isHidden = true
        view.addSubview(noNotificationView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationView.center = view.center
    }
    
    
    
}
extension NotificationsViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier  , for: indexPath) as! NotificationLikeEventTableViewCell
            cell.config(with: model)
            cell.delegate = self
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier  , for: indexPath) as! NotificationFollowEventTableViewCell
            cell.config(with: model)
            cell.delegate = self
            return cell
        }
    
        
//        cell.config(with: UserNotification(user: User(name: (firstname: "Mina", lastname: "Hany"), birthdate: Date(), gender: .male, bio: "Life Fair", counts: UserCount(followers: 12, following: 100, posts: 33), joinDate: Date(), profilePic: URL()), text: "Followewr", Type: .like(post: <#T##UserPost#>)))
    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 64
//    }
    
    
}
extension NotificationsViewController:NotificationFollowEventTableViewCellDelegate{
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Follow Un Follow Tapped")
        //When Tap Follow Or Not
    }
    
    
}

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate{
    func didTapPostButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.modalPresentationStyle = .fullScreen
            vc.title = post.postUserType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Dev Issue Should never called.")
            
        }

    }
    
    
    
}
