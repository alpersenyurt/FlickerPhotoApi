//
//  PhotoDetailPresenter.swift
//  PhotoView
//
//  Created by Alper Senyurt on 14/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit



protocol PhotoDetailPresenterInput:PhotoDetailViewControllerOutput,PhotoDetailInteractorOutput{
}



class PhotoDetailPresenter:PhotoDetailPresenterInput{
    
    weak var view: PhotoDetailViewControllerInput!
    var interactor: PhotoDetailInteractorInput!
    
    func loadLargePhotoImage() {
    
        self.interactor.loadUIImageFromUrl()
    }
  
    /**
     Passing data from PhotoSearch Module Rooter
     
     - parameter photoModel: photoModel from before viewcontroller
     */
    func saveSelectedPhotoModel(photoModel:FlickrPhotoModel){
    
        self.interactor.configurePhotoModel(photoModel)
    }

    /**
     result comes from Interactor
     
     - parameter image: photo Image
     */

    func sendloadedPhotoImage(image:UIImage){
    
        self.view.addLargeLoadedPhoto(image)
    }


    /**
     result comes from interactor
     */
    func getPhotoImageTitle(){
    
    
      let imageTitle  = self.interactor.getPhotoImageTitle()
       self.view.addPhotoImageTitle(imageTitle)

    }

}