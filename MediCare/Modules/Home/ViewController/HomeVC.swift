//
//  HomeVC.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/29/22.
//

import UIKit

class HomeVC: UIViewController {

   
    // MARK: - Outlets
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var clFirstAidKits: UICollectionView!
    // MARK: - Constants and variables
    
    //Variables for collectionview
    let NUMBER_OF_COLUMN : CGFloat = 2
    let TOP_INSET : CGFloat = 2
    let BOTTOM_INSET : CGFloat = 2
    let LEFT_INSET : CGFloat = 2
    let RIGHT_INSET : CGFloat = 2
    let SECTION_INSET : CGFloat = 2
    let INTER_ITEM_INSET : CGFloat = 0
    let LINE_SPACE : CGFloat = 0
    
    // MARK: - ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        dynamicCLHeight()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
   
// MARK: - IBAction Functions

// MARK: - Additional Functions
    func registerCollectionView(){
        clFirstAidKits.register(UINib(nibName: "FirstAidKitCell", bundle: nil), forCellWithReuseIdentifier: "FirstAidKitCell")
        
    }
    
    func dynamicCLHeight() {
        let height  = clFirstAidKits.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }

}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstAidKitCell", for: indexPath) as! FirstAidKitCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = (collectionViewWidth - LEFT_INSET - RIGHT_INSET - (INTER_ITEM_INSET * (NUMBER_OF_COLUMN - 1))) / NUMBER_OF_COLUMN
        let itemHeight : CGFloat = 200
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: TOP_INSET, left: LEFT_INSET, bottom: BOTTOM_INSET, right: RIGHT_INSET)
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LINE_SPACE
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return INTER_ITEM_INSET
    }
}

