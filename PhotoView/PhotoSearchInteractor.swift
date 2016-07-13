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
    func fetchAllPhotosFromApi(searchTag:String,page:NSInteger)
}

protocol PhotoSearchInteractorOutput: class
{
 
    func providedPhotos(photos:[FlickrPhotoModel],totalPages:NSInteger)

}
class PhotoSearchInteractor:PhotoSearchInteractorInput{

    weak var presenter: PhotoSearchInteractorOutput!
    var APIDataManager: FlickrPhotoSearchProtocol!

    func fetchAllPhotosFromApi(searchTag:String,page:NSInteger){
    
        self.APIDataManager.fetchPhotosForSearchText(searchTag,page: page) { (error:NSError?,totalPages:NSInteger,flickerPhotos:[FlickrPhotoModel]?) in
            

            if let photos = flickerPhotos{
            
                self.presenter.providedPhotos(photos,totalPages:totalPages )
            }
        }
    }

}
