//
//  HarryPotterAlbumImages.swift
//  BestHarryPotterCharacters
//
//  Created by Varun Narayanswamy on 2/29/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HarryPotterAlbumImages: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var charImageArray = [String]()
    
    //constants for layout
    let spacing : CGFloat = 8
    let numberItemsPerRow : CGFloat = 3
    let spacingBetweenCells : CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...14 {
            charImageArray.append("char" + String(i))
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        //apply to collection view
        collectionView.collectionViewLayout = layout

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (2 * spacing) + ((numberItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberItemsPerRow
        
        return CGSize(width: width, height: width)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check identified
        if segue.identifier == "showImage" {
            //get ref to destination controller
            let detailVC = segue.destination as! IndividualImageView
            //get the cell
            let indexPath = collectionView.indexPath(for: sender as! CollectionViewImageCell)
            
            //set properties in destination
            detailVC.title = "Character #\(indexPath!.row + 1)"
            detailVC.imageName = charImageArray[indexPath!.row]
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return charImageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewImageCell
        
            // constructs UIImage and set source of imageView
            let image = UIImage(named: charImageArray[indexPath.row])
            cell.HarryPotterImage.image = image
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 50, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: 50, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header : HarryPotterTitle?
        var footer : HarryPotterFooter?
        
        if kind == UICollectionView.elementKindSectionHeader {
            print("this is found")
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HarryPotterTitle
            
            header?.titleLabel.text = "Best In Order"
        }
        
        if kind == UICollectionView.elementKindSectionFooter{
            print("anotherone")
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? HarryPotterFooter
                   
            footer?.footer.text = "Fred and George are considered the same person"
            return footer!
        }
        return header!
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
