//
//  HomeInteractorTests.swift
//  iBuy
//
//  Created by Baran Baran on 16.09.2024.
//

import XCTest
@testable import iBuy

final class HomeInteractorTests: XCTestCase {
    
    var sut: HomeInteractor! // System Under Test (sut)
    var presenterSpy: HomePresenterSpy!
    var workerSpy: HomeWorkerSpy!
    
    override func setUp() {
        super.setUp()
        presenterSpy = HomePresenterSpy()
        workerSpy = HomeWorkerSpy()
        sut = HomeInteractor(presenter: presenterSpy, worker: workerSpy) // Burada worker tipinin uyumlu olduğundan emin olun
    }
    
    override func tearDown() {
        sut = nil
        presenterSpy = nil
        workerSpy = nil
        super.tearDown()
    }
    
    // Test: Features fetch request triggers worker and presenter correctly
    func testFetchFeaturesCallsWorkerAndPresentsData() {
        // Given
        let request = HomeModels.FetchFeatures.Request()
        
        // When
        sut.fetchFeatures(request: request)
        
        // Then
        XCTAssertTrue(workerSpy.fetchFeaturesCalled, "Fetch features should trigger worker")
        XCTAssertTrue(presenterSpy.presentFeaturesCalled, "Features data should be presented")
    }
    
    // Spies
    class HomePresenterSpy: HomePresentationLogic {
        var presentFeaturesCalled = false
        func present(response: HomeModels.FetchFeatures.Response) {
            presentFeaturesCalled = true
        }
        func present(response: HomeModels.FetchProducts.Response) {}
    }
    
    class HomeWorkerSpy: HomeNetworkWorker {
        var fetchFeaturesCalled = false
        func fetchFeatures(completion: @escaping (Result<[FeatureResponse], ServiceError>) -> Void) {
            fetchFeaturesCalled = true
            // FeatureResponse modeli eksiksiz olarak sağlanıyor
            let mockFeatures = [FeatureResponse(name: "Test Feature", url: "https://example.com/feature")]
            completion(.success(mockFeatures))
        }
        
        func fetchProducts(with categoryName: String, completion: @escaping (Result<[ProductResponse], ServiceError>) -> Void) {}
    }
}
