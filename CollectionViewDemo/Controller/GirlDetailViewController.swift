//
//  GirlDetailViewController.swift
//  CollectionViewDemo
//
//  Created by Terry Jason on 2024/1/5.
//

import UIKit

class GirlDetailViewController: UIViewController {
    
    var girl: Girl?
    
    // MARK: - @IBOulet
    
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = girl?.name
        }
    }
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = girl?.description
            descriptionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var girlImageView: UIImageView! {
        didSet {
            girlImageView.image = UIImage(named: girl?.imageName ?? "")
        }
    }
    
    @IBOutlet var likesLabel: UILabel! {
        didSet {
            guard let girl = girl else { return }
            likesLabel.text = "❤️ \(girl.likes) Likes"
        }
    }
    
}

// MARK: - Life Cycle

extension GirlDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
