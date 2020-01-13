//
//  ViewController.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class SearchPhotoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var photos = [Photo](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    var userQuery = ""{
        didSet{
            switch searchBar.selectedScopeButtonIndex{
            case 0:
                FlickrPhotoAPI.getPhotos(FlickrPhotoAPI.getNameURL(userQuery)) { [weak self] result in
                    switch result{
                    case .failure(let netError):
                        DispatchQueue.main.async{
                            self?.showAlert("Loading Error", "Could not load photo data in SearchPhotoViewController: \(netError)")
                        }
                    case .success(let photoArr):
                        self?.photos = photoArr
                    }
                }
            case 1:
                print(searchBar.selectedScopeButtonIndex)
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        searchBar.placeholder = "Enter search query here"
    }
    
    @IBAction func favouritesButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}

extension SearchPhotoViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? CustomImageCell else {
            return UITableViewCell()
        }
        xCell.setUp(photos[indexPath.row])
        return xCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
     
}

extension SearchPhotoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else {
            showAlert("Segue Error", "Could not instantiate instance of DetailedViewController.")
            return
        }
        detailedVC.currentPhoto = photos[indexPath.row]
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension SearchPhotoViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        userQuery = searchText
    }
}
