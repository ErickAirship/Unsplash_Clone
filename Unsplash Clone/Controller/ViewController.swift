//
//  ViewController.swift
//  Unsplash Clone
//
//  Created by Gavin Brown on 3/10/23.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = profileButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let featuredController = FeaturedViewController()
        let featuredIcon = UITabBarItem(title: nil, image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        featuredController.tabBarItem = featuredIcon
        let favoritesController = FavoritesViewController()
        let favoritesIcon = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        favoritesController.tabBarItem = favoritesIcon
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        // tabBar.backgroundColor = .black <- Uncomment to change background color
        
        viewControllers = [featuredController, favoritesController]
    }
    
    



}



extension ViewController {
    var profileButton: UIBarButtonItem {
        let button = UIButton(type: .custom)
            button.setBackgroundImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
            button.tintColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
    
            let profileMenuButtonItem = UIBarButtonItem(customView: button)
            profileMenuButtonItem.customView?.widthAnchor.constraint(equalToConstant: 32).isActive = true
            profileMenuButtonItem.customView?.heightAnchor.constraint(equalToConstant: 32).isActive = true
    
            return profileMenuButtonItem
    }
}
