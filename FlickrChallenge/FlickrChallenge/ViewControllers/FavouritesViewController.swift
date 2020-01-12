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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setUo(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        
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
    
}
