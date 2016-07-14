//
//  PhotoDetailInteractor.swift
//  PhotoView
//
//  Created by Alper Senyurt on 14/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit

protocol PhotoDetailInteractorInput:class{


    func configurePhotoModel(photoModel:FlickrPhotoModel)
    func getPhotoImageTitle()->String
    func loadUIImageFromUrl()
    
}

protocol PhotoDetailInteractorOutput: class
{

    func sendloadedPhotoImage(image:UIImage)

}

class PhotoDetailInteractor:PhotoDetailInteractorInput{
    
    weak var presenter: PhotoDetailInteractorOutput!
    var photoModel: FlickrPhotoModel?
    var imageDataManager: FlickrPhotoLoadImageProtocol!

    
    func configurePhotoModel(photoModel:FlickrPhotoModel){
    
        self.photoModel = photoModel
    }
    
    func loadUIImageFromUrl() {
    
        imageDataManager.loadUImageFromUrl(self.photoModel!.largePhotoUrl) { (image, error) in
            
            if let image = image{
            
                self.presenter.sendloadedPhotoImage(image)
            
            }
        }
        
    
    }
    
    func getPhotoImageTitle()->String{
    
        if let title = self.photoModel?.title{

            return title
        }
        return ""
    }

    
}
