//
//  FeaturedViewController.swift
//  Unsplash Clone
//
//  Created by Gavin Brown on 3/11/23.
//

import UIKit

class FeaturedViewController: UIViewController {
   private let featuredView = TabView()
   private let API: UnsplashApi = UnsplashApi()


    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = .black
        // Do any additional setup after loading the view.
        featuredView.viewTitle.text = "Featured"
        // MARK: Need to set these here since collection view is defined in UIView class and loaded
        featuredView.photosCollection.delegate = self
        featuredView.photosCollection.dataSource = self
        view = featuredView
       fetchRandomPhotos()
    }
    
    private func fetchRandomPhotos() {
        Task {
            do {
                let photos = try await API.randomPhotos()
               
                await MainActor.run {
                    featuredView.setPhotosCollection(photos:photos)
                
                }
            } catch {
                print(error)
            }
        }
    }
   

}

extension FeaturedViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredView.photosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoId", for: indexPath) as! ImageViewCell
        cell.data = featuredView.photosData[indexPath.item]
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = view.frame.height
        
        let cellWidth = width - 16
        let cellHeight = (height / 4)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
