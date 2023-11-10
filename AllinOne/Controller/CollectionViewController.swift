//
//  CollectionViewController.swift
//  AllinOne
//
//  Created by flash on 10/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var itemArr = Array<String>()
    var items = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 1...50{
            items.append(i.description)
        }
    }
    let reuseIdentifier = "cell" 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLbl.text = self.items[indexPath.row]
        cell.myLbl.textAlignment = .center
        // The row value is the same as the index of the desired text within the array.
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
}

