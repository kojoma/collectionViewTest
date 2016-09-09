//
//  ViewController.swift
//  collectionViewTest
//
//  Created by masha on 2016/09/10.
//  Copyright © 2016年 masha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     var cellNumberList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
        for i in 0..<100 {
            cellNumberList.append(i)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        cell.setupCell(cellNumberList[indexPath.row])
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellNumberList.count
    }
}

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var cellNumberLabel: UILabel!
    
    func setupCell(cellNumber: Int) -> CustomCell {
        self.backgroundColor = UIColor.blueColor()
        self.cellNumberLabel.text = cellNumber.description
        self.cellNumberLabel.textColor = UIColor.whiteColor()
        return self
    }
}
