//
//  PhotoSearchPresenter.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit

protocol PhotoSearchPresenterInput:PhotoViewControllerOutput,PhotoSearchInteractorOutput{
}



class PhotoSearchPresenter:PhotoSearchPresenterInput{

    weak var view: PhotoViewControllerInput!
    var interactor: PhotoSearchInteractorInput!
    var rooter: PhotoSearchRooterInput!

    /**
     Presenter says interactor Viewcontroller needs photos
     
     - parameter searchTerma: search Text
     - parameter page:        page Number
     */
    func fetchPhotos(searchTerma: String,page:NSInteger){
    
        
        if view.getTotalPhotoCount() == 0 {
            
            view.showWaitingView()
        }

        self.interactor.fetchAllPhotosFromApi(searchTerma,page: page)
    }

    /**
     Service returns photos and interactor passes all data to presenenter which make view display them
     
     - parameter photos:     all Photo
     - parameter totalPages: totalPages
     */
    func providedPhotos(photos:[FlickrPhotoModel],totalPages:NSInteger){
    
    
        self.view.hideWaitingView()
        self.view.displayFetchedPhotos(photos,totalPages: totalPages)
    }
    
    
    /**
     Show error message from service
     error message should be customize so Actually I use defaul message

     - parameter error: NSError
     */
    func serviceError(error:NSError){
    

        self.view.displayErrorView(defaultErrorMessage);
    
    }

    func gotoProductDetailScreen(){
    

        self.rooter.navigateToPhotoDetail()
    }

    func passDataToNextScene(segue: UIStoryboardSegue){
    
        self.rooter.passDataToNextScene(segue)
    }

    
}