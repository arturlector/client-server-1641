//
//  BlurFilterViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 29.11.2021.
//

import UIKit
import CoreImage

class BlurFilterViewController: UITableViewController {

    var images = [
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!,
        UIImage(named: "treeSmall")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        blurImages()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let inputImage = images[indexPath.row]
        
        cell.imageView?.image = inputImage
        //blur(image: inputImage, andApplyToView: cell.imageView!)

        return cell
    }
    
    func blurImages() {
        var bluredImages = images
        let dispatchGroup = DispatchGroup()
        
        for element in bluredImages.enumerated() {
            
            DispatchQueue.global().async(group: dispatchGroup) {
                
                let inputImage = element.element
                let inputCIImage = CIImage(image: inputImage)!
                
                let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: inputCIImage])!
                let outputImage = blurFilter.outputImage!
                let context = CIContext()
                
                let cgiImage = context.createCGImage(outputImage, from: outputImage.extent)
                
                bluredImages[element.offset] = UIImage(cgImage: cgiImage!)
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.images = bluredImages
            self.tableView.reloadData()
        }
    }
    
//    func blur(image: UIImage, andApplyToView view: UIImageView) {
//
//        DispatchQueue.global(qos: .userInteractive).async {
//
//            let inputImage = UIImage(named: "treeSmall")!
//            let inputCIImage = CIImage(image: inputImage)! //Переводится в CIImage - слои
//
//            let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: inputCIImage])!
//            let outputImage = blurFilter.outputImage!
//            let context = CIContext()
//
//            let cgiImage = context.createCGImage(outputImage, from: outputImage.extent) //CGImage - битмап
//
//            let bluredImage = UIImage(cgImage: cgiImage!)
//
//            //view.image = bluredImage //UIImage
//
//            DispatchQueue.main.async {
//                view.image = bluredImage
//            }
//        }
//    }
    


}
