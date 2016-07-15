//
//  NavigationExtension.swift
//  PhotoView
//
//  Created by Alper Senyurt on 15/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics:UIBarMetrics.Default)
        navigationBar.translucent = true
        navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(false, animated:true)
        navigationBar.tintColor = UIColor.whiteColor();

    }
    
    public func hideTransparentNavigationBar() {
    

        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImageForBarMetrics(UIBarMetrics.Default), forBarMetrics:UIBarMetrics.Default)
        navigationBar.translucent = false
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
        navigationBar.tintColor = UIColor.grayColor();
        setNavigationBarHidden(false, animated:false)

    }
}