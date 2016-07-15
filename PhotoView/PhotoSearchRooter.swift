//
//  PhotoSearchRooter.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit

protocol PhotoSearchRooterInput:class
{

    func navigateToPhotoDetail()
    func passDataToNextScene(segue: UIStoryboardSegue)

}


class PhotoSearchRooter:PhotoSearchRooterInput{

    weak var viewController: PhotoViewController!

    
    // MARK: Navigation
    
    /**
     the router responsible from how to navigate to another scene.
     */
    func navigateToPhotoDetail()
    {
        
         viewController.performSegueWithIdentifier("ShowPhotoDetail", sender: nil)

    }


    /**
      Teach the router which scenes it can communicate with
     
     - parameter segue:
     */
    
    func passDataToNextScene(segue: UIStoryboardSegue)
    {
        
        if segue.identifier == "ShowPhotoDetail" {
            passDataToShowPhotoDetailScene(segue)
        }
    }
    
    
    /**
     navigate to another module
     
     - parameter segue: segue
     */
    func passDataToShowPhotoDetailScene(segue: UIStoryboardSegue)
    {
        if let selectedIndexPath = viewController.photoCollectionView.indexPathsForSelectedItems()?.first {
             let selectedPhotoModel = viewController.photos[selectedIndexPath.row]
              let showDetailViewController = segue.destinationViewController as! PhotoDetailViewController
            
            showDetailViewController.presenter.saveSelectedPhotoModel(selectedPhotoModel)
        }
    }

}