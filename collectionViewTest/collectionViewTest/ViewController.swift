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
    
    // MARK: - UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CustomCell = createCell(self, collectionView: collectionView, cellForItemAtIndexPath: indexPath)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellNumberList.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.updateCellNumberList(indexPath.row)
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItemsAtIndexPaths([indexPath])
            }, completion: nil)
    }
    
    // MARK: - private
    private func updateCellNumberList(index: Int) {
        self.cellNumberList.removeAtIndex(index)
    }

    private func createCell(parent: ViewController, collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> CustomCell {
        let cell: CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        cell.deleteClosure = {(cell: CustomCell) in
            let errorAlert = UIAlertController(title: "削除しますか？", message: "", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "はい",
                                              style: .Default,
                                              handler: {(action: UIAlertAction!) -> Void in
                                                let indexPath = self.collectionView.indexPathForCell(cell)
                                                self.updateCellNumberList(indexPath!.row)
                                                self.collectionView.performBatchUpdates({
                                                    self.collectionView.deleteItemsAtIndexPaths([indexPath!])
                                                    }, completion: nil)

            })
            let cancelAction = UIAlertAction(title: "いいえ",
                                             style: .Cancel,
                                             handler: {(action: UIAlertAction!) -> Void in})
            errorAlert.addAction(defaultAction)
            errorAlert.addAction(cancelAction)
            self.presentViewController(errorAlert, animated: true, completion: nil)
        }
        cell.setupCell(cellNumberList[indexPath.row])
        return cell
    }
}

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var cellNumberLabel: UILabel!
    
    var deleteClosure : ((cell: CustomCell) -> ())?

    func setupCell(cellNumber: Int) -> CustomCell {
        self.backgroundColor = UIColor.blueColor()
        self.cellNumberLabel.text = cellNumber.description
        self.cellNumberLabel.textColor = UIColor.whiteColor()
        self.cellNumberLabel.userInteractionEnabled = true
        self.cellNumberLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMenu(_:))))
        return self
    }

    func didTapMenu(sender: UITapGestureRecognizer) {
        deleteClosure!(cell: self)
    }
}
