//
//  Alerts.swift
//  UserPhotosTest
//
//  Created by Vasiliy Vasilchenko on 8/14/17.
//  Copyright © 2017 vasyl. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func showPhotoAlert() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction.init(title: "Gallery", style: .default, handler: { [weak self] _ in
            self?.presentImagePicker(with: .photoLibrary)
        })
        alert.addAction(gallery)
        
        let camera = UIAlertAction.init(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.presentImagePicker(with: .camera)
        })
        alert.addAction(camera)
        
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showDeletePhotoAlert(by indexPath: IndexPath) {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction.init(title: "Delete", style: .default, handler: { [weak self] _ in
            self?.deleteImage(at: indexPath)
        })
        alert.addAction(delete)
        
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)

    }

}
