//
//  FlickrPhotoModel.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import Foundation


struct FlickrPhotoModel {
    
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: NSURL {
        return self.flickrImageURL()
    }
   
    var largePhotoUrl: NSURL {
        return self.flickrImageURL("b")
    }

    func flickrImageURL(size:String = "m") -> NSURL {
        return NSURL(string: "http://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_\(size).jpg")!
    }

}