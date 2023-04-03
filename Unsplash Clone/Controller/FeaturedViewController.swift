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
    private var isLoading = false
    var photos: [UnsplashResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = .black
        // Do any additional setup after loading the view.
        featuredView.viewTitle.text = "Featured"
        // MARK: Need to set these here since collection view is defined in UIView class and loaded
        featuredView.photosCollection.delegate = self
        featuredView.photosCollection.dataSource = self
        featuredView.photosCollection.prefetchDataSource = self
        view = featuredView
       fetchRandomPhotos()
    }
    
    private func fetchRandomPhotos() {
        Task {
            do {
                isLoading = true
                photos = try await API.randomPhotos()
                isLoading = false

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
        let imageUrl = featuredView.photosData[indexPath.item].urls.full
        cell.setImage(urlString: imageUrl)
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

extension FeaturedViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last, lastIndexPath.item >= photos.count - 1, !isLoading {
            fetchRandomPhotos()
        }
    }
}
