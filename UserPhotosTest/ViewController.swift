//
//  ViewController.swift
//  UserPhotosTest
//
//  Created by Vasiliy Vasilchenko on 8/13/17.
//  Copyright © 2017 vasyl. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var imagePicker = UIImagePickerController()
    var userPhotosSelected = true
    
    var userPhotos = [Photo]()
    var certificatePhotos = [CertificatePhoto]()
    
    var resultsUserPhotos: Results<Photo>?
    var resultsCertificatesPhotos: Results<CertificatePhoto>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photos = DataStore.shared.listOfPhotos() {
            userPhotos = photos
        }
        if let certPhotos = DataStore.shared.listOfCertificates() {
            certificatePhotos = certPhotos
        }
        configureTableView()
        imagePicker.delegate = self
    }

    func configureTableView() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20), style: .grouped)
        
        tableView.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(TextCell.self, forCellReuseIdentifier: "TextCell")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        view.addSubview(tableView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tableView": tableView]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tableView": tableView]))
    }

}


