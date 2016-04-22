//
//  OrderHelper.swift
//  PizzaApp
//
//  Created by Juan on 4/22/16.
//  Copyright © 2016 Juan. All rights reserved.
//

import UIKit

protocol OrderHelperDelegate {
    func orderHelperDidGetOrdersWithSortedConfiguration(orderHelper:OrderHelper, orderConfig: Dictionary<String, Int>, sortedKeys: Array<String>);
}


class OrderHelper: NSObject {
    
    var delegate: OrderHelperDelegate?
    
    func loadOrdersAndFrequency(){

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            var orderConfig = Dictionary<String, Int>();
            
            let path = NSBundle.mainBundle().pathForResource("pizzas", ofType: "json");
            let fileContents = NSData(contentsOfFile: path!);
            
            if (fileContents != nil) {
                
                do {
                    let orders = try NSJSONSerialization.JSONObjectWithData(fileContents!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                    orderConfig = self.getOrderCounts(orders);
                    
                } catch {
                    print(error)
                }
                
                let sortedKeys = (orderConfig as NSDictionary).keysSortedByValueUsingComparator({
                    ($1 as! NSNumber).compare($0 as! NSNumber)
                }) as! Array<String>;
                
                dispatch_sync(dispatch_get_main_queue(), {
                
                    self.delegate?.orderHelperDidGetOrdersWithSortedConfiguration(self, orderConfig: orderConfig, sortedKeys: sortedKeys);
                })
            }
        })
    }
    
    
    func getOrderCounts(orders: NSArray) -> Dictionary<String, Int> {
        
        var orderConfig = Dictionary<String, Int>();
        var toppings = NSArray();
        var topping = String();
        
        for order in orders {
            toppings = order["toppings"] as! NSArray;
            topping = toppings.componentsJoinedByString(",");
            
            if orderConfig[topping] == nil {
                orderConfig[topping] = 1
            } else {
                orderConfig[topping]! += 1
            }
        }
        return orderConfig;
    }
}



