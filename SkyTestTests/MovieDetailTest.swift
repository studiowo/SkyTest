//
//  MovieDetailTest.swift
//  SkyTestTests
//
//  Created by Renato Matos de Paula on 04/12/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import Quick
import Nimble
import KIF_Quick

@testable import SkyTest

class DetailMovieViewControllerTest: KIFSpec {
    
    override func spec() {
        
        let model = MovieModel(id: "123456",
                               title: "Renato Sarro",
                               overview: "afsdfds",
                               duration: "4:20",
                               release_year: "2018",
                               cover_url: "",
                               backdrops_url: [""])
        let coordinator = MoviesCoordinator()
        let controller = DetailMovieViewController(with: coordinator, movieModel: model)
        
        describe("when application is initialize") {
            context("instrumented tests", closure: {
                describe("when movie detail screen is open", {
                    beforeEach {
                        WindowHelper.showInTestWindow(viewController: controller)
                    }
                    
                    afterEach {
                        viewTester().waitForAnimationsToFinish()
                    }
                    
                    it("should to show movie title", closure: {
                        viewTester().usingLabel("Renato Sarro").waitForView()
                    })
                })
            })
            
            context("unit tests", {
                it("model should not be nil", closure: {
                    expect(controller.model).notTo(beNil())
                })
                it("detail movie protocol coordinator should conforms to MoviesCoordinatorProtocol", closure: {
                    expect(coordinator).to(beAKindOf(MoviesCoordinatorProtocol.self))
                })
            })
        }
        
    }
}
