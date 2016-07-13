//
//  FlickerApi.swift
//  PhotoView
//
//  Created by Alper Senyurt on 09/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import Foundation

protocol FlickrPhotoSearchProtocol:class {
    

    func fetchPhotosForSearchText(searchText: String,page:NSInteger, onCompletion: (NSError?, NSInteger,[FlickrPhotoModel]?) -> Void) -> Void

}
class FlickrProvider:FlickrPhotoSearchProtocol {

    struct Errors {
        static let invalidAccessErrorCode = 100
    }
    
    struct FlickrAPI {
        static let APIDomain = "FlickrAPIDomain"
        static let APIKey = "1c83f8b8d6c88c440ee1e8fc58c0ee08"
        
//        static let TagsSearchFormat = "https://api.flickr.com/services/rest/?format=json&nojsoncallback=?&method=flickr.photos.search&tags=%@&extras=description,owner_name,url_s,url_l,url_o&api_key=%@&page=%d"
     
        static let TagsSearchFormat = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"
 
        static let TagsAndGeoSearchFormat = "https://api.flickr.com/services/rest/?format=json&nojsoncallback=?&method=flickr.photos.search&tags=%@&extras=description,owner_name,url_s,url_l,url_o,geo&has_geo=1&api_key=%@&page=%d&lat=%f&long=%f"
    }
    
    struct FlickerAPIMetadataKeys {
        static let FailureStatusCode = "code"
    }

    func fetchPhotosForSearchText(searchText: String,page:NSInteger, onCompletion: (NSError?,NSInteger, [FlickrPhotoModel]?) -> Void) -> Void {
    
        let escapedSearchText: String = searchText.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        let arguments: [CVarArgType] = [FlickrAPI.APIKey, escapedSearchText,page]
        let format: String = FlickrAPI.TagsSearchFormat
        
        let photosURL = String(format: format, arguments: arguments)
        
        
        let url: NSURL = NSURL(string: photosURL)!

        
        let searchTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("Error fetching photos: \(error)")
                onCompletion(error,0,nil)
                return
            }
            
            do {
                
                let resultsDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results[FlickerAPIMetadataKeys.FailureStatusCode] as? Int {
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: FlickrAPI.APIDomain, code: statusCode, userInfo: nil)
                        onCompletion(invalidAccessError,0,nil)
                        return
                    }
                }
                

                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                guard let totalPageCountString = photosContainer["total"] as? String else { return }
                guard let totalPageCount = NSInteger(totalPageCountString as String) else { return }

                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                
                
                let flickrPhotos: [FlickrPhotoModel] = photosArray.map { photoDictionary in
                    
                    let photoId = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    let flickrPhoto = FlickrPhotoModel(photoId: photoId, farm: farm, secret: secret, server: server, title: title)
                    return flickrPhoto
                }
                
                onCompletion(nil,totalPageCount,flickrPhotos)
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(error,0,nil)
                return
            }
            
        })
        searchTask.resume()
    }
    
    
}