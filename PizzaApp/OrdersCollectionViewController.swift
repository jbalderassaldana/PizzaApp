//
//  OrdersCollectionViewController.swift
//  PizzaApp
//
//  Created by Juan on 4/22/16.
//  Copyright © 2016 Juan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class OrdersCollectionViewController: UICollectionViewController, OrderHelperDelegate {

    var orderConfig: Dictionary<String, Int>?
    var sortedKeys: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let orderHelper = OrderHelper();
        orderHelper.delegate = self;
        orderHelper.loadOrdersAndFrequency();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! OrdersCollectionViewCell
        
        if orderConfig != nil && sortedKeys != nil {
            cell.lblConfiguration.text = sortedKeys![indexPath.row];
            cell.lblCount.text = String(orderConfig![sortedKeys![indexPath.row]]!);
        }
        
        return cell
    }
    
    // MARK: OrderHelperDelegate
    
    func orderHelperDidGetOrdersWithSortedConfiguration(orderHelper: OrderHelper, orderConfig: Dictionary<String, Int>, sortedKeys: Array<String>) {
        
        self.orderConfig = orderConfig;
        self.sortedKeys = sortedKeys;
        
        self.collectionView?.reloadData();
    }
}
