//
//  ViewController.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit

protocol PhotoViewControllerInput:class
{
    func displayFetchedPhotos(photos: [FlickrPhotoModel])
}

protocol PhotoViewControllerOutput
{
    func fetchPhotos(searchTerma: String)
}

class ViewController: UIViewController,PhotoViewControllerInput {

    var presenter: PhotoViewControllerOutput!

    var photos: [FlickrPhotoModel] = []

    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        PhotoSearchConfigurator.sharedInstance.configure(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.performSearchWithText("car")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayFetchedPhotos(photos: [FlickrPhotoModel]){
    
        self.photos = photos;
        
        print("photos\(self.photos)");
    }
 
    private func performSearchWithText(searchText: String){
    
        self.presenter.fetchPhotos(searchText)
    }
   
//    private func performSearchWithText(searchText: String) {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//        FlickrProvider.fetchPhotosForSearchText(searchText, onCompletion: { (error: NSError?, flickrPhotos: [FlickrPhotoModel]?) -> Void in
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//            if error == nil {
//                self.photos = flickrPhotos!
//                print("photos \(flickrPhotos)")
//            } else {
//                self.photos = []
//                if (error!.code == FlickrProvider.Errors.invalidAccessErrorCode) {
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        self.showErrorAlert()
//                    })
//                }
//            }
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.title = searchText
//            })
//        })
//    }
//    
//    private func showErrorAlert() {
//        let alertController = UIAlertController(title: "Search Error", message: "Invalid API Key", preferredStyle: .Alert)
//        let dismissAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
//            
//        }
//        alertController.addAction(dismissAction)
//        self.presentViewController(alertController, animated: true) {
//            
//        }
//    }


}

