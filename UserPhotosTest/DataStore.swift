//
//  DataStore.swift
//  UserPhotosTest
//
//  Created by Vasiliy Vasilchenko on 8/14/17.
//  Copyright © 2017 vasyl. All rights reserved.
//

import UIKit
import RealmSwift

class DataStore: NSObject {
    
    static let shared: DataStore = {
        let instance = DataStore()
        return instance
    }()
    
    lazy var realm = try! Realm()
    
    func addNewPhoto(path: String) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            let photo = Photo()
            photo.filePath = path
            
            try! realm.write {
                realm.add(photo)
            }
        }
    }
    
    func addNewCertificate(path: String) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            let certPhoto = CertificatePhoto()
            certPhoto.filePath = path
            
            try! realm.write {
                realm.add(certPhoto)
            }
        }
    }
    
    func listOfPhotos() -> [Photo]? {
        let photos = realm.objects(Photo.self)
        var returnedPhtos = [Photo]()
        for var photo in photos {
            returnedPhtos.append(photo)
        }
        return returnedPhtos
    }
    
    func listOfCertificates() -> [CertificatePhoto]? {
        let certPhotos = realm.objects(CertificatePhoto.self)
        var returnedPhtos = [CertificatePhoto]()
        for var photo in certPhotos {
            returnedPhtos.append(photo)
        }
        return returnedPhtos
    }
    
    func resultsListOfPhotos() -> Results<Photo>? {
        let photos = realm.objects(Photo.self)
        return photos
    }
    
    func resultsListOfCertificates() -> Results<CertificatePhoto>? {
        let certPhotos = realm.objects(CertificatePhoto.self)
        return certPhotos
    }
    
    func delete(photoObject: Photo) {
        try! realm.write {
            realm.delete(realm.objects(Photo.self).filter("filePath = %@", photoObject.filePath))
        }
    }
    
    func delete(certificateObject: CertificatePhoto) {
        try! realm.write {
            realm.delete(realm.objects(CertificatePhoto.self).filter("filePath = %@", certificateObject.filePath))
        }
    }
    
    
}
