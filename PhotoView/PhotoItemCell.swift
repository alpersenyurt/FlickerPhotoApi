//
//  PhotoItemCell.swift
//  PhotoView
//
//  Created by Alper Senyurt on 13/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import UIKit

class PhotoItemCell: UICollectionViewCell,ReuseIdentifierProtocol {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
     

        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
}
