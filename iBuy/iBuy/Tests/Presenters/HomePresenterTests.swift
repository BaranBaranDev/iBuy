//
//  HomePresenterTests.swift
//  iBuy
//
//  Created by Baran Baran on 16.09.2024.
//

import XCTest
@testable import iBuy

final class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter! // System Under Test (sut)
    var viewControllerSpy: HomeViewControllerSpy!
    
    override func setUp() {
        super.setUp()
        sut = HomePresenter()
        viewControllerSpy = HomeViewControllerSpy()
        sut.controller = viewControllerSpy // Presenter ile ViewController arasındaki bağlantıyı kuruyoruz
    }
    
    override func tearDown() {
        sut = nil
        viewControllerSpy = nil
        super.tearDown()
    }
    
    // Test: Presenter formats and presents features data correctly
    func testPresentFeaturesFormatsDataCorrectly() {
        // Given
        let features = [FeatureResponse(name: "Test Feature", url: "https://example.com/feature")] // FeatureResponse doğru şekilde oluşturuluyor
        let response = HomeModels.FetchFeatures.Response(features: features)
        
        // When
        sut.present(response: response)
        
        // Then
        XCTAssertTrue(viewControllerSpy.displayFeaturesCalled, "Displaying features should be called") // ViewController'ın doğru çağrıldığını kontrol ediyoruz
        XCTAssertEqual(viewControllerSpy.viewModel?.features.count, 1, "Features count should match") // ViewModel'deki özellik sayısının doğru olduğunu kontrol ediyoruz
    }
    
    // Spies
    class HomeViewControllerSpy: HomeDisplayLogic {
        var displayFeaturesCalled = false
        var viewModel: HomeModels.FetchFeatures.ViewModel?
        
        // ViewController'ın display methodunun çağrılmasını simüle ediyoruz
        func display(viewModel: HomeModels.FetchFeatures.ViewModel) {
            displayFeaturesCalled = true
            self.viewModel = viewModel
        }
        
        func display(viewModel: HomeModels.FetchProducts.ViewModel) {}
    }
}
