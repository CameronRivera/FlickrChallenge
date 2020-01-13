//
//  FavouritesViewController.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var photographs = [Photo](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    var handler = PersistenceHelper<Photo>(fileName: "FlickrFavourites")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        navigationItem.title = "Favourites"
        do {
            photographs = try handler.getObjects()
        } catch {
            showAlert("Persistence Error", "Could not retrieve photos from file FlickrFavourites")
        }
    }
}

extension FavouritesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? CustomImageCell else {
            showAlert("Dequeue Cell Error", "Could not dequeue custom cell for tableView")
            return UITableViewCell()
        }
        xCell.setUp(photographs[indexPath.row])
        return xCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photographs.count
    }
    
}

extension FavouritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else {
            showAlert("Segue Error", "Could not instantiate instance of Detailed View Controller.")
            return
        }
        detailedVC.currentPhoto = photographs[indexPath.row]
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}
