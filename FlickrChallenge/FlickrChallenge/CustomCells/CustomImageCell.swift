//
//  CustomImageCell.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class CustomImageCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setUp(_ photo: Photo){
        descriptionLabel.text = photo.title
        
        let photoURL = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        
        photoImageView.getImage(photoURL) { [weak self] result in
            switch result{
            case .failure(let netError):
                print("Encountered Error Loading photo in cell: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self?.photoImageView.image = image
                }
            }
        }
    }
}
