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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "imageCell")
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
    
}

extension SearchPhotoViewController: UISearchBarDelegate{
    
}
