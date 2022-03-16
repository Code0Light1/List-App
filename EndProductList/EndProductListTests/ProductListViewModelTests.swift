//
//  ProductListViewModelTests.swift
//  EndProductListTests
//
//  Created by kiranjith on 15/03/2022.
//

import XCTest
@testable import EndProductList

class ProductListViewModelTests: XCTestCase {
    var viewModel : ProductsViewModel!
    
    fileprivate var service : MockProductService!
    
    override func setUp() {
        super.setUp()
        self.service = MockProductService()
        self.viewModel = ProductsViewModel(service: service)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func test_fetch_with_no_service() {
        
        let expectation = XCTestExpectation(description: "No service")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch products
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchProducts()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_fetch_products() {
        
        let expectation = XCTestExpectation(description: "Product fetch")
        
        // giving a service mocking products
        service.products = [Product(image: "dummy url", name: "Shoe", price: "100", id: "1")]
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        viewModel.products.bind { products in
            expectation.fulfill()
        }
        
        viewModel.fetchProducts()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_fetch_no_products() {
        
        let expectation = XCTestExpectation(description: "No products")
        
        // giving a service mocking error during fetching products
        service.products = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchProducts()
        wait(for: [expectation], timeout: 5.0)
    }
}
    


fileprivate class MockProductService : ProductsServiceProtocol {
    
    var products : [Product]?

    func fetchProducts(_ completion: @escaping ((Result<[Product], ErrorResult>) -> Void)) {

        if let products = products {
            completion(Result.success(products))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
}


