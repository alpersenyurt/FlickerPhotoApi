//
//  PhotoDetailViewController.swift
//  PhotoView
//
//  Created by Alper Senyurt on 14/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerInput:class
{
    func addLargeLoadedPhoto(photo:UIImage)

    func addPhotoImageTitle(title:String)
    
}

protocol PhotoDetailViewControllerOutput
{
    func saveSelectedPhotoModel(photoModel:FlickrPhotoModel)
    func loadLargePhotoImage()
    func getPhotoImageTitle()
}

class PhotoDetailViewController: UIViewController,PhotoDetailViewControllerInput {

    var presenter: PhotoDetailViewControllerOutput!

    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ask title and image from presenter
        self.presenter.getPhotoImageTitle()
        self.presenter.loadLargePhotoImage()

    }
    override func awakeFromNib()
    {
        
        super.awakeFromNib()
        PhotoDetailConfigurator.sharedInstance.configure(self)

    }

    
    /**
     result comes from presenter
     
     - parameter photo: image
     */
    func addLargeLoadedPhoto(photo:UIImage){
    
        self.photoImageView.image = photo
    }

    /**
     result comes from presenter
     
     - parameter title: photo title
     */
    
    func addPhotoImageTitle(title:String){
    
        self.photoTitleLabel.text = title

    }


    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.hideTransparentNavigationBar()
        
    }
    
    
}
