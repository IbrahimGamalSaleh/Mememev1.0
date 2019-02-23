//
//  MemeCollectionViewController.swift
//  Mememev1.0
//
//  Created by Srikar Thottempudi on 2/20/19.
//  Copyright © 2019 Srikar Thottempudi. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController {
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    @IBOutlet weak var memeCollectionFlowLayout: UICollectionViewFlowLayout!
    var memes: [MememeGenerator]! {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 1.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        memeCollectionFlowLayout.minimumInteritemSpacing = space
        memeCollectionFlowLayout.minimumLineSpacing = space
        memeCollectionFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memeCollectionView.reloadData() // Updating the memes array for new memes created and making sure all components are rendered on screen.
    }
}

extension MemeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let memeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        memeCell.cellImage.image = memes[indexPath.row].memeMeImage
        return memeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select item at is called.")
        let memeDetailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailController") as! MemeDetailViewController
        memeDetailController.detailImage = memes[indexPath.row].memeMeImage
        navigationController?.pushViewController(memeDetailController, animated: true)
    }
}
