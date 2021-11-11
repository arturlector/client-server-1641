//
//  PhotosCollectionController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 11.11.2021.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

final class PhotosCollectionController: UICollectionViewController {

    private var photos: [Photo] = []
    private let photosAPI = PhotosAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.collectionViewLayout = self

        //контроллер держит сервис
        photosAPI.getPhotos { [weak self] photos in
            //гарантирует что блок полностью выполниться даже если контроллер будет удален из памяти
            guard let self = self else { return }
            
            //сервис держит контроллер
            self.photos = photos
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        let photo = photos[indexPath.row]
        if let photoUrl = URL(string:photo.photoUrl) {
            cell.imageView.load(url: photoUrl)
        }
       
        return cell
    }
}

extension PhotosCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsInRow: CGFloat = 2 //сколько хотим ячеек на строке
        let offsetOfWidth = 20 * (itemsInRow + 1)
        let availableWidth = collectionView.frame.width - offsetOfWidth
        let widthForItem = availableWidth / itemsInRow
        return CGSize(width: widthForItem, height: widthForItem)
        
        //return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
