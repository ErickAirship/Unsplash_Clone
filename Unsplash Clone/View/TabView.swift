//
//  FeaturedView.swift
//  Unsplash Clone
//
//  Created by Gavin Brown on 3/10/23.
//

import UIKit
import Kingfisher

class TabView: UIView {
    // MARK: Needed to collect the photos passed in the view controller
   var photosData:[UnsplashResponse] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHomeContainer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    let viewTitleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewTitle: UILabel = {
       let title = UILabel()
        title.textColor = .white
        title.font = UIFont(name: "SFCompact-Semibold", size: 36)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let photosCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ImageViewCell.self, forCellWithReuseIdentifier: "photoId")
        collection.backgroundColor = .black
        return collection
    }()
    
    
    func setPhotosCollection(photos: [UnsplashResponse]) -> Void {
        photosData = photos
        photosCollection.reloadData()
    }
    
    func setupHomeContainer() -> Void {
        addSubview(viewTitleContainer)
        addSubview(photosCollection)
        setupViewTitleContainer()
        setupPhotosCollectionContainer()
    }
    
    
    func setupViewTitleContainer() -> Void {
        viewTitleContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        viewTitleContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewTitleContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        viewTitleContainer.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        viewTitleContainer.addSubview(viewTitle)
        setupTitle()
       
    }
    
    func setupTitle() -> Void {
        viewTitle.leftAnchor.constraint(equalTo: viewTitleContainer.leftAnchor, constant: 20).isActive = true
    }
    
    func setupPhotosCollectionContainer() -> Void {
        photosCollection.topAnchor.constraint(equalTo: viewTitleContainer.bottomAnchor, constant: 10).isActive = true
        photosCollection.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        photosCollection.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

class ImageViewCell: UICollectionViewCell {
    func setImage(urlString: String) {
        guard let url = URL(string: urlString), imageContainer.image == nil else { return }
        
        //Ideally downsampling would be done by passing into the URL param.
        //By passing in bounds.size.width/bounds.size.height
        
        let processor = DownsamplingImageProcessor(size: bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 12)
        
        imageContainer.kf.indicatorType = .activity
        imageContainer.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
            ])
    }
    
    let imageContainer: UIImageView = {
       let container = UIImageView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.contentMode = .scaleAspectFill
        container.layer.cornerRadius = 12
        // MARK: Clips to bounds makes image fit within the corner radius
        container.clipsToBounds = true
        return container
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageView() {
        // MARK: When in a cell and customizing data be sure to add your custom view to the contentView(subview) this is the only way your component will show up
        contentView.addSubview(imageContainer)
        imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }
}

