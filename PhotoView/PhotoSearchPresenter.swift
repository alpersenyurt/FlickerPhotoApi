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

    func fetchPhotos(searchTerma: String){
    
        self.interactor.fetchAllPhotosFromApi(searchTerma)
    }

    func providedPhotos(photos:[FlickrPhotoModel]){
    
    
        self.view.displayFetchedPhotos(photos)
    }

}