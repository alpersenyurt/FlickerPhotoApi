//
//  PhotoDetailConfigurator.swift
//  PhotoView
//
//  Created by Alper Senyurt on 14/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit


class PhotoDetailConfigurator
{
    // MARK: Object lifecycle
    
    class var sharedInstance: PhotoDetailConfigurator
    {
        struct Static {
            static var instance: PhotoDetailConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = PhotoDetailConfigurator()
        }
        
        return Static.instance!
    }
    
    // MARK: Configuration
    
    func configure(viewController: PhotoDetailViewController)
    {
        
        let APIDataManager:FlickrPhotoLoadImageProtocol = FlickrProvider()
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor;
        
        interactor.imageDataManager = APIDataManager
        
        
    }
}