//
//  PhotoViewController.swift
//  PhotoView
//
//  Created by Alper Senyurt on 13/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit
import SDWebImage


protocol PhotoViewControllerInput:class
{
    func displayFetchedPhotos(photos: [FlickrPhotoModel],totalPages:NSInteger)
    func showWaitingView()
    func hideWaitingView()
    func displayErrorView(errorMessage:String);
    func getTotalPhotoCount()->NSInteger;

}

protocol PhotoViewControllerOutput
{
    func fetchPhotos(searchTerma: String,page:NSInteger)
    func gotoProductDetailScreen()
    func passDataToNextScene(segue: UIStoryboardSegue)

}



class PhotoViewController: UIViewController,PhotoViewControllerInput {
    
    var presenter: PhotoViewControllerOutput!

    var photos: [FlickrPhotoModel] = []
    var currentPage:NSInteger  = 1
    var totalPages:NSInteger = 1
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        PhotoSearchConfigurator.sharedInstance.configure(self)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSearchWithText(photoSearchKey)

    }
    
    
    override func viewWillAppear(animated: Bool) {
    
        self.title = photoSearchKey

    }

    override func viewWillDisappear(animated: Bool) {
        self.title = ""
    
        self.navigationController?.presentTransparentNavigationBar()
    }
    
    
    
    /**
     
     Service Result
     
     Presenter return us with photo results
     
     - parameter photos:     all photos
     - parameter totalPages: total Pages
     */
    func displayFetchedPhotos(photos: [FlickrPhotoModel],totalPages:NSInteger){
    
        self.photos.appendContentsOf(photos)
        self.totalPages = totalPages

        dispatch_async(dispatch_get_main_queue(),{
            
            self.photoCollectionView.reloadData()
            
        })

    }
    
    
    /**
     request photo servise result from Presenter
     
     - parameter searchText: search term
     */
    private func performSearchWithText(searchText: String){
        
        self.presenter.fetchPhotos(searchText,page: self.currentPage)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        self.presenter.passDataToNextScene(segue)
    }
    
  
    
    func getTotalPhotoCount()->NSInteger{
    
        return self.photos.count
    }
    
    
    // MARK: ActivityView
    func showWaitingView(){
    
        let alert = UIAlertController(title: nil, message: waitingKey, preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func hideWaitingView(){
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Show Error Messages
    func displayErrorView(errorMessage:String){
        
        let refreshAlert = UIAlertController(title: errorTitle, message: errorMessage , preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title:okKey , style: .Default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    

}

// MARK:- UICollectionView DataSource

extension PhotoViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        // Photo cells + Loading cell.
        if (self.currentPage < self.totalPages) {
            return self.photos.count + 1;
        }
        
        // Photo cells
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if indexPath.row < self.photos.count {
            return self.photoItemCellCollectionView(collectionView, cellForItemAtIndexPath: indexPath)
        }
            
        else {
            self.currentPage += 1 ;

            self.performSearchWithText(photoSearchKey)

            return self.loadingItemCellCollectionView(collectionView, cellForItemAtIndexPath: indexPath);
        }

       
    }
    
 
    func photoItemCellCollectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoItemCell.defaultReuseIdentifier,forIndexPath:indexPath) as! PhotoItemCell
        let flickerModel = self.photos[indexPath.row]
        
        
        cell.photoImageView.alpha = 0
        
        cell.photoImageView.sd_setImageWithURL(flickerModel.photoUrl) { (image, error, cache, url) in
            
            cell.photoImageView.image = image
            UIView.animateWithDuration(0.2, animations: {
                cell.photoImageView.alpha = 1.0
            })
            
        }
        
        return cell
        
    }
    
    func loadingItemCellCollectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoLoadingCell.defaultReuseIdentifier,forIndexPath:indexPath) as! PhotoLoadingCell

        return cell
        
    }

    
}



// MARK:- UICollectionViewDelegate Methods

extension PhotoViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        self.presenter.gotoProductDetailScreen()
    }
    
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectioViewDelegateFlowLayout methods
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var itemSize : CGSize
        let length = (UIScreen.mainScreen().bounds.width)/3-1

        
        if indexPath.row < self.photos.count {

            itemSize = CGSizeMake(length, length)

        } else {

            itemSize = CGSizeMake(CGRectGetWidth(self.photoCollectionView.bounds), 50.0)
        }


        return itemSize


        
    }


    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        
        return 0.5
    
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
    
        return 0.5
    }
    
}


