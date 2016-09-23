//
//  ChalmersCard_Screenshots.swift
//  ChalmersCard Screenshots
//
//  Created by Jesper Lindström on 2016-08-17.
//  Copyright © 2016 SHARPMIND. All rights reserved.
//

import XCTest

class ChalmersCard_Screenshots: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        app.launchArguments = ["USE_FAKE_DATA"]
        setupSnapshot(app)
        app.launch()
    }
    
    func testExample() {
        let app = XCUIApplication()
        snapshot("0BalanceHigh")
        
        app.buttons["Settings"].tap()
        snapshot("3Edit")
        
        app.navigationBars.element(boundBy: 0).buttons.element(boundBy: 2).tap()
        snapshot("1BalanceMedium")
        
        app.buttons["Settings"].tap()
        app.navigationBars.element(boundBy: 0).buttons.element(boundBy: 2).tap()
        snapshot("1BalanceLow")
    }
    
}
