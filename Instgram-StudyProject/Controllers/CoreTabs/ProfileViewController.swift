//
//  ProfileViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 06/02/2022.
//

import UIKit

class ProfileViewController: UIViewController {
   
//    let collectionView : UICollectionView = {
    private var collectionView: UICollectionView?
//    }()
    private var userPosts = [UserPost]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
//        collectionView.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let size = (view.width - 4 )/3
        layout.itemSize = CGSize(width: size, height: size)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        
        
        guard let collectionView = collectionView else {
            return
        }
        //Cell
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        //Header
        collectionView.register(ProfilecInfoCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfilecInfoCollectionReusableView.identifier)
        
        collectionView.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView.delegate =  self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame  = view.bounds
    }
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    @objc private func didTapSettingsButton(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
extension ProfileViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 0 
        }
//        return userPosts.count
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let images = ["test","test1","test2","test3","test4","test5","test6","test7","test8","test9","test10","test11","test12"]
        
        cell.configure(debug: images[indexPath.row])
//        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     // open PostController , get model data
//        let model = userPosts[indexPath.row]
//        let vc = PostViewController(model: nil)
//        vc.title = "Post"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
        
//    }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else{
            //Footer
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            let tabs = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            tabs.delegate = self
            return tabs
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfilecInfoCollectionReusableView.identifier, for: indexPath) as! ProfilecInfoCollectionReusableView
        header.delegate = self
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: collectionView.width,
                          height: collectionView.height/3)
        }
        return CGSize(width: 50,
                      height: 50)
    }
}
extension ProfileViewController: ProfileInforCollectionReusableViewDelegate{
    func profileHeaderDidTapPostsButton(_ header: ProfilecInfoCollectionReusableView) {
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfilecInfoCollectionReusableView) {
        let vc = ListViewController(data: [UserFollow(username: "Mina Hany", image: "test2",title: "MINA10M",isFollow: .following),UserFollow(username: "Osama Gamil", image: "test4",title: "Osos44",isFollow: .following),UserFollow(username: "Lochi Joe", image: "test5",title: "joe1111",isFollow: .notFollowing)] )
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfilecInfoCollectionReusableView) {
        let vc = ListViewController(data:[UserFollow(username: "Mohamed Ahmad", image: "test9",title: "AhmadMO",isFollow: .notFollowing),UserFollow(username: "Osama Gamil", image: "test4",title: "Osos44",isFollow: .following),UserFollow(username: "Adam Saad", image: "test5",title: "adam_saad",isFollow: .notFollowing)])
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfilecInfoCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    
}
extension ProfileViewController: ProfileTapsCollectionReusableViewDelegate{
    func didTapGridButton() {
        print("Grid ")
        //Reload CollectionView With main Data
    }
    
    func didTapTagButton() {
        //Reload CollectionView With Tagged Data
        print("Tagged")
    }
    
    
}
