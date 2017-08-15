//
//  UsersTableViewDataSource.swift
//  UserPhotosTest
//
//  Created by Vasiliy Vasilchenko on 8/13/17.
//  Copyright © 2017 vasyl. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: 44))
        headerView.backgroundColor = .white
        let headerLabel = UILabel.init(frame: headerView.frame)
        headerLabel.text = section == 0 ? "User ID Photos" : "Certificate Photos"
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? userPhotos.count + 1 : certificatePhotos.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section) {
        case 0:
            if userPhotos.count == indexPath.row {
                return configureTextCell(at: indexPath, text: "Add new photo")
            } else {
                return configurePhotoCell(by: userPhotos, at: indexPath)
            }
        case 1:
            if certificatePhotos.count == indexPath.row {
                return configureTextCell(at: indexPath, text: "Add new certificate")
            } else {
                return configurePhotoCell(by: certificatePhotos, at: indexPath)
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func configureTextCell(at indexPath: IndexPath, text: String) -> TextCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as!TextCell
        cell.addNewPhotoButton.setTitle(text, for: .normal)
        
        return cell
    }
    
    func configurePhotoCell(by array: [Photo], at indexPath: IndexPath) -> PhotoCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = array[indexPath.row].filePath
        let image = UIImage.init(contentsOfFile: photo)
        cell.photoImageView.image = image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0, userPhotos.count == indexPath.row {
            userPhotosSelected = true
            showPhotoAlert()
        } else if indexPath.section == 1, certificatePhotos.count == indexPath.row {
            userPhotosSelected = false
            showPhotoAlert()
        } else {
            showDeletePhotoAlert(by: indexPath)
        }
    }
    
    //MARK: ImagePicker Delegate
    
    func presentImagePicker(with sourceType: UIImagePickerControllerSourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicker.dismiss(animated: true, completion: nil)
            
            let filePath = saveImageToDocuments(image: image, fileNameWithExtension: "\(Date().timeIntervalSince1970)picture.jpg")
            if userPhotosSelected == true {
                reloadTablevView(Photo(), filePath: filePath)
            } else {
                reloadTablevView(CertificatePhoto(), filePath: filePath)
            }
        }
    }
    
    func reloadTablevView(_ photoClass: Photo, filePath: String) {
        photoClass.filePath = filePath
        var indexP = IndexPath.init()
        if ((photoClass as? CertificatePhoto) != nil) {
            certificatePhotos.append(photoClass as! CertificatePhoto)
            indexP = IndexPath.init(row: certificatePhotos.count - 1, section: 1)
        }else {
            userPhotos.append(photoClass)
            indexP = IndexPath.init(row: userPhotos.count - 1, section: 0)
        }
        tableView.beginUpdates()
        tableView.insertRows(at: [indexP], with: .fade)
        tableView.endUpdates()
    }
    
    func saveImageToDocuments(image: UIImage, fileNameWithExtension: String) -> String{
        let imageData = UIImageJPEGRepresentation(image, 0.6)!
        
        do {
            let docDir = try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let imageURL = docDir.appendingPathComponent(fileNameWithExtension)
            saveToDataBase(path: imageURL.path)
            
            do {
                try imageData.write(to: imageURL, options: .atomic)
            } catch {
                print("There was an error while saving")
            }
            return imageURL.path
        } catch {
            print("There was an error while creating directory")
        }
        return ""
    }
    
    func saveToDataBase(path: String) {
        if userPhotosSelected {
            DataStore.shared.addNewPhoto(path: path)
        } else {
            DataStore.shared.addNewCertificate(path: path)
        }
    }
    
    func deleteImage(at indexPath: IndexPath) {
        var photoObject = Photo()
        if indexPath.section == 0 {
            resultsUserPhotos = DataStore.shared.resultsListOfPhotos()
            photoObject = (resultsUserPhotos?[indexPath.row])!
            userPhotos.remove(at: indexPath.row)
            DataStore.shared.delete(photoObject: photoObject)
            
        } else {
            resultsCertificatesPhotos = DataStore.shared.resultsListOfCertificates()
            photoObject = (resultsCertificatesPhotos?[indexPath.row])!
            certificatePhotos.remove(at: indexPath.row)
            DataStore.shared.delete(certificateObject: photoObject as! CertificatePhoto)
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
}
