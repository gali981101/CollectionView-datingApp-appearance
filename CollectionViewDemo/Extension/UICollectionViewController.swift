//
//  Utils+UICollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Terry Jason on 2024/1/5.
//

import UIKit

extension UICollectionViewController {
    
    open override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let appearance = navigationController?.navigationBar.standardAppearance {
            guard let customFont = UIFont(name: "RubikDoodleShadow-Regular", size: 45.0) else { return }
            
            appearance.configureWithOpaqueBackground()
            
            appearance.titleTextAttributes = [.foregroundColor: UIColor.systemMint]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemMint, .font: customFont]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
}
