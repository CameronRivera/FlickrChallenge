//
//  UIViewController+Extensions.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ title: String, _ message: String){
        let alertControl = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertControl.addAction(action)
        present(alertControl, animated: true, completion: nil)
    }
    
}
