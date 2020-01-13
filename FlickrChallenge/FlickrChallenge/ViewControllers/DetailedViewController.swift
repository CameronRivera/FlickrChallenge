//
//  DetailedViewController.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    var currentPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp(){
        navigationItem.rightBarButtonItem?.image = UIImage(systemName:"heart")
        navigationItem.rightBarButtonItem?.title =  ""
        guard let curPhoto = currentPhoto else {
            return
        }
        
        if curPhoto.description.content == "" {
            descriptionText.text = "No description available"
        } else {
            descriptionText.text = curPhoto.description.content
        }
        
        imageView.getImage(curPhoto.url ?? "") { [weak self] result in
            switch result {
            case .failure(let netError):
                DispatchQueue.main.async {
                    self?.showAlert("Image Error", "Could not retrieve Image: \(netError)")
                }
            case .success(let image):
                DispatchQueue.main.async{
                    self?.imageView.image = image
                }
            }
        }
        
    }
    
    @IBAction func favouritesButtonPressed(_ sender: UIBarButtonItem){
        guard let curPhoto = currentPhoto else {
            print("Current Photo contains a value of nil.")
            return
        }
        let handler = PersistenceHelper<Photo>(fileName: "FlickrFavourites")
        var currentFavourites = [Photo]()
        
        do{
            currentFavourites = try handler.getObjects()
        } catch {
            
        }
        
        if !currentFavourites.contains(curPhoto){
            do {
                try handler.save(curPhoto)
                showAlert("Success", "Photo Saved to favourites")
                navigationItem.rightBarButtonItem?.isEnabled = false
            } catch {
                showAlert("Persistence Save Error", "Could not save photo to file FlickrFavourites.")
            }
        } else {
            showAlert("Oops", "It would seem you have already added this photo to your favourites.")
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
}
