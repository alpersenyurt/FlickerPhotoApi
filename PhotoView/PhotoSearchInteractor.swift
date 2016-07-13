//
//  PhotoSearchInteractor.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import Foundation

protocol PhotoSearchInteractorInput:class
{
    func fetchAllPhotosFromApi(searchTag:String)
}

protocol PhotoSearchInteractorOutput: class
{
 
    func providedPhotos(photos:[FlickrPhotoModel])

}
class PhotoSearchInteractor:PhotoSearchInteractorInput{

    weak var presenter: PhotoSearchInteractorOutput!
    var APIDataManager: FlickrPhotoSearchProtocol!

    func fetchAllPhotosFromApi(searchTag:String){
    
        self.APIDataManager.fetchPhotosForSearchText(searchTag) { (error:NSError?,flickerPhotos:[FlickrPhotoModel]?) in
            

            if let photos = flickerPhotos{
            
                self.presenter.providedPhotos(photos)
            }
        }
    }

}
