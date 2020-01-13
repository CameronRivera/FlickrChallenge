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
    
    var urlString = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    func setUp(_ photo: Photo){
        urlString = photo.url ?? ""
        if photo.description.content != ""{
            descriptionLabel.text = photo.description.content
        } else {
            descriptionLabel.text = "No description"
        }
        
        photoImageView.getImage(photo.url ?? "") { [weak self] result in
            switch result{
            case .failure(let netError):
                print("Encountered Error Loading photo in cell: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    if self?.urlString == photo.url{
                        self?.photoImageView.image = image
                    }
                }
            }
        }
    }
}
