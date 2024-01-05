//
//  GirlCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Terry Jason on 2024/1/5.
//

import UIKit

private let reuseIdentifier = "Cell"

class GirlCollectionViewController: UICollectionViewController {
    
    enum Section {
        case all
    }
    
    private var girlSet: [Girl] = [
        Girl(name: "Girl-1", imageName: "img1", description: "I Love Cat and Dog.", likes: 39, isFavorite: false),
        Girl(name: "Girl-2", imageName: "img2", description: "Do you want to play GTA5 with me.", likes: 29, isFavorite: false),
        Girl(name: "Girl-3", imageName: "img3", description: "I haven't exercised for a long time since my last breakup.", likes: 19, isFavorite: false),
        Girl(name: "Girl-4", imageName: "img4", description: "Like cooking, laundry, listening to music.", likes: 49, isFavorite: false),
        Girl(name: "Girl-5", imageName: "img5", description: "I love super big bowl of ice cream.", likes: 29, isFavorite: false),
        Girl(name: "Girl-6", imageName: "img6", description: "I like to do art work while watching horror movies.", likes: 59, isFavorite: false),
        Girl(name: "Girl-7", imageName: "img7", description: "The hooker please leave.", likes: 19, isFavorite: false),
        Girl(name: "Girl-8", imageName: "img8", description: "Absolutely no retouching, natural beauty.", likes: 99, isFavorite: false),
        Girl(name: "Girl-9", imageName: "img9", description: "Who wants to go see Toy Story 3 with me?", likes: 72, isFavorite: false),
        Girl(name: "Girl-10", imageName: "img10", description: "Boxing, entrepreneurship, swimming, health.", likes: 68, isFavorite: false),
        Girl(name: "Girl-11", imageName: "img11", description: "Looking for a casual relationship with no burdens.", likes: 100, isFavorite: false),
        Girl(name: "Girl-12", imageName: "img12", description: "Stop going to school!", likes: 60, isFavorite: false),
        Girl(name: "Girl-13", imageName: "img13", description: "When can I have a holiday?", likes: 98, isFavorite: false),
        Girl(name: "Girl-14", imageName: "img14", description: "Let’s go skiing in the Arctic together next time.", likes: 55, isFavorite: false),
        Girl(name: "Girl-15", imageName: "img15", description: "I live next door to you, next door.", likes: 62, isFavorite: false),
        Girl(name: "Girl-16", imageName: "img16", description: "It doesn’t snow in Brooklyn’s night sky.", likes: 128, isFavorite: false),
        Girl(name: "Girl-17", imageName: "img17", description: "Are you Cat Pie or Patrick Star?", likes: 77, isFavorite: false),
        Girl(name: "Girl-18", imageName: "img18", description: "Bill Gates and Pitbull? I choose the latter.", likes: 97, isFavorite: false),
        Girl(name: "Girl-19", imageName: "img19", description: "Make a lot of money, eat, eat, eat.", likes: 89, isFavorite: false),
        Girl(name: "Girl-20", imageName: "img20", description: "When will the lockdown be lifted?", likes: 76, isFavorite: false),
        Girl(name: "Girl-21", imageName: "img21", description: "If you bully me, you are dead.", likes: 69, isFavorite: false)
    ]
    
    private var shareEnabled: Bool = false
    private var selectedGirls: [(girl: Girl, snapshot: UIImage)] = []
    
    lazy var dataSource = configureDataSource()
    
    // MARK: - @IBOulet
    
    @IBOutlet var shareButton: UIBarButtonItem!
    
}

// MARK: - Life Cycle

extension GirlCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 100, height: 150)
            layout.estimatedItemSize = .zero
            layout.minimumInteritemSpacing = 10
        }
        
        collectionView.dataSource = dataSource
        updateSnapshot()
    }
    
}

// MARK: - @IBAction

extension GirlCollectionViewController {
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
        guard shareEnabled else {
            shareModeStart()
            return
        }
        
        guard selectedGirls.count > 0 else {
            shareModeEnd()
            return
        }
        
        let snapshots = selectedGirls.map { $0.snapshot }
        
        present(activityController(snapshots), animated: true)
        
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
}

// MARK: - Prepare Segue

extension GirlCollectionViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGirlDetail" {
            guard let indexPaths = collectionView.indexPathsForSelectedItems else { fatalError() }
            let destinationVC = segue.destination as! GirlDetailViewController
            
            destinationVC.girl = girlSet[indexPaths.first!.row]
            collectionView.deselectItem(at: indexPaths[0], animated: false)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showGirlDetail" {
            if shareEnabled {
                return false
            }
        }
        
        return true
    }
    
}

// MARK: - DiffableDataSource

extension GirlCollectionViewController {
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Girl> {
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Girl>(collectionView: collectionView) { collectionView, indexPath, girl in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GirlCollectionViewCell
            
            cell.girlImageView.image = UIImage(named: girl.imageName)
            cell.girlLikesLabel.text = "❤️ \(girl.likes) Likes"
            
            cell.backgroundView = girl.isFavorite ? UIImageView(image: UIImage(named: "feature-bg")) : nil
            
            let selectedBackground = UIView()
            
            selectedBackground.layer.borderColor = UIColor.label.cgColor
            selectedBackground.layer.borderWidth = 3.0
            
            cell.selectedBackgroundView = selectedBackground
            
            return cell
        }
        
        return dataSource
    }
    
}

// MARK: - Snapshot

extension GirlCollectionViewController {
    
    private func updateSnapshot(animatingChange: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Girl>()
        
        snapshot.appendSections([.all])
        snapshot.appendItems(girlSet, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
    
}

// MARK: - Helper Methods

extension GirlCollectionViewController {
    
    private func shareModeStart() {
        shareEnabled = true
        collectionView.allowsMultipleSelection = true
        shareButton.title = "Done"
        shareButton.style = UIBarButtonItem.Style.done
    }
    
    private func shareModeEnd() {
        self.shareEnabled = false
        self.collectionView.allowsMultipleSelection = false
        self.shareButton.title = "Share"
        self.shareButton.style = UIBarButtonItem.Style.plain
    }
    
}

// MARK: - UIActivityViewController

extension GirlCollectionViewController {
    
    private func activityController(_ snapshots: [UIImage]) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: snapshots, applicationActivities: nil)
        
        controller.completionWithItemsHandler = { activityType, completed, returnedItem, error in
            
            guard let indexPaths = self.collectionView.indexPathsForSelectedItems else { fatalError() }
            
            for indexPath in indexPaths {
                self.collectionView.deselectItem(at: indexPath, animated: false)
            }
            
            self.selectedGirls.removeAll(keepingCapacity: true)
            
            self.shareModeEnd()
        }
        
        return controller
    }
    
}

// MARK: - UICollectionViewDelegate

extension GirlCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard shareEnabled else { return }
        
        guard let selectedGirl = dataSource.itemIdentifier(for: indexPath) else { fatalError() }
        guard let snapshot = collectionView.cellForItem(at: indexPath)?.snapshot else { fatalError() }
        
        selectedGirls.append((girl: selectedGirl, snapshot: snapshot))
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard shareEnabled else { return }
        
        guard let deSelectedGirl = dataSource.itemIdentifier(for: indexPath) else { fatalError() }
        
        if let index = selectedGirls.firstIndex(where: { $0.girl.name == deSelectedGirl.name }) {
            selectedGirls.remove(at: index)
        }
    }
    
}
