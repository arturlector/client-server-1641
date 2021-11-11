//
//  PhotosCollectionController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 11.11.2021.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "PhotoCell"

final class PhotosCollectionController: UICollectionViewController {

    //private var photos: [Photo] = []
    private var photos: Results<PhotoModel>?
    
    private let photosAPI = PhotosAPI()
    private let photoDatabase = PhotosDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //контроллер держит сервис
        photosAPI.getPhotos { [weak self] photos in
            //гарантирует что блок полностью выполниться даже если контроллер будет удален из памяти
            guard let self = self else { return }
            
            self.photoDatabase.deleteAll()
            self.photoDatabase.add(photos)
            self.photos = self.photoDatabase.load()
            
            self.collectionView.reloadData()
            
            //сервис держит контроллер
            //self.photos = photos
            //self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        guard let photos = photos else { return 0 }
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        let photo = photos?[indexPath.row]
        if let photoUrl = URL(string:photo?.assetUrl ?? "") {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
