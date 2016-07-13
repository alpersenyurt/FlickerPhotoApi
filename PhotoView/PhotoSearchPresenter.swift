//
//  PhotoSearchPresenter.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import Foundation

protocol PhotoSearchPresenterInput:PhotoViewControllerOutput,PhotoSearchInteractorOutput{
}



class PhotoSearchPresenter:PhotoSearchPresenterInput{

    weak var view: PhotoViewControllerInput!
     var interactor: PhotoSearchInteractorInput!
     var rooter: PhotoSearchRooterInput!

    func fetchPhotos(searchTerma: String,page:NSInteger){
    
        self.interactor.fetchAllPhotosFromApi(searchTerma,page: page)
    }

    func providedPhotos(photos:[FlickrPhotoModel],totalPages:NSInteger){
    
    
        self.view.displayFetchedPhotos(photos,totalPages: totalPages)
    }

}