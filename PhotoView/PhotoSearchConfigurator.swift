//
//  PhotoSearchConfigurator.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit



class PhotoSearchConfigurator
{
    // MARK: Object lifecycle
    
    class var sharedInstance: PhotoSearchConfigurator
    {
        struct Static {
            static var instance: PhotoSearchConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = PhotoSearchConfigurator()
        }
        
        return Static.instance!
    }
    
    // MARK: Configuration
    
    /**
     All presenter modules  are created
     
     - parameter viewController: view Controller for Module
     */
    func configure(viewController: PhotoViewController)
    {
        
        let APIDataManager:FlickrPhotoSearchProtocol = FlickrProvider()
        let interactor = PhotoSearchInteractor()
        let router = PhotoSearchRooter()
        router.viewController = viewController
        let presenter = PhotoSearchPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.rooter = router
        interactor.presenter = presenter
        presenter.interactor = interactor;

        interactor.APIDataManager = APIDataManager


    }
}
