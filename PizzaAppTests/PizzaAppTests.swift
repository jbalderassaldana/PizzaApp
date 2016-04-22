//
//  PizzaAppTests.swift
//  PizzaAppTests
//
//  Created by Juan on 4/22/16.
//  Copyright © 2016 Juan. All rights reserved.
//

import XCTest
@testable import PizzaApp

class PizzaAppTests: XCTestCase {
    
    let orderHelper = OrderHelper();
    var orders = NSMutableArray();
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        orders.addObject(NSDictionary(object: ["pepperoni"], forKey: "toppings"));
        orders.addObject(NSDictionary(object: ["feta cheese"], forKey: "toppings"));
        orders.addObject(NSDictionary(object: ["pepperoni"], forKey: "toppings"));
        orders.addObject(NSDictionary(object: ["bacon"], forKey: "toppings"));
        orders.addObject(NSDictionary(object: ["sausage, beef"], forKey: "toppings"));
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCounts() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let orderCounts = orderHelper.getOrderCounts(orders);

        XCTAssertEqual(orderCounts["pepperoni"], 2);
        XCTAssertEqual(orderCounts["feta cheese"], 1);
        XCTAssertEqual(orderCounts["bacon"], 1);
        XCTAssertEqual(orderCounts["sausage, beef"], 1);
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
