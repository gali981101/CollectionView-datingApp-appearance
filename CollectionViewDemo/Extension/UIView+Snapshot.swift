//
//  UIView+Snapshot.swift
//  CollectionViewDemo
//
//  Created by Terry Jason on 2024/1/5.
//

import UIKit

extension UIView {
    
    var snapshot: UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        
        UIGraphicsEndImageContext()
        return image
    }
    
}
