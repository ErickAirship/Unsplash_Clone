//
//  FavoritesViewController.swift
//  Unsplash Clone
//
//  Created by Gavin Brown on 3/14/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    let favoritesView = TabView()
    
    
    override func loadView() {
        favoritesView.viewTitle.text = "Favorites"
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
    }
    

}
