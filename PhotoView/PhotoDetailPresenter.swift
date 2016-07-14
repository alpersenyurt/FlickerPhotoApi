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
    
    func saveSelectedPhotoModel(photoModel:FlickrPhotoModel){
    
        self.interactor.configurePhotoModel(photoModel)
    }

  

    func sendloadedPhotoImage(image:UIImage){
    
        self.view.addLargeLoadedPhoto(image)
    }

    func getPhotoImageTitle(){
    
    
      let imageTitle  = self.interactor.getPhotoImageTitle()
       self.view.addPhotoImageTitle(imageTitle)

    }

}