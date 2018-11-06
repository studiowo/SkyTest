//
//  SkyTestTests.swift
//  SkyTestTests
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import Quick
import KIF_Quick

@testable import SkyTest

class ListMovieViewController: KIFSpec {

    override func spec() {
        
        describe("when application is initialize") {
            
            it("should to show list movies", closure: {
                viewTester().usingIdentifier("listMoviesCollection").waitForView()
            })
            
            context("when tap on movie cell", closure: {
                it("should to show movie detail", closure: {
                    viewTester().usingIdentifier("listMoviesCollection").waitForView()
                    viewTester().usingIdentifier("listMovieCell_0").tap()
                    
                    viewTester().usingIdentifier("detailMovieViewController").waitForView()
                })
            })
        }
        
    }

}
