//
//  FiltersTests.swift
//  CocktailsTests
//
//  Created by Vedran Hernaus on 10.05.2024..
//

import XCTest
import Combine
@testable import Cocktails

final class FiltersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_givenAlcoholicCategoryAndGlassIds_whenAlcoholicCategoryAndGlassIdsAreAssigned_thenAllIdsShouldBeEqual() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        let givenAlcoholicId = "Alcoholic"
        let givenCategoryId = "Cocktail"
        let givenGlassId = "Wine Glass"
        
        // SUT
        let viewModel = FiltersViewModel()
       
        // When
        viewModel.onAlcoholicFilterViewTap(with: givenAlcoholicId)
        viewModel.onCategoryFilterViewTap(with: givenCategoryId)
        viewModel.onGlassFilterViewTap(with: givenGlassId)
        
        // Then
        XCTAssertEqual(viewModel.selectedAlcoholicId, givenAlcoholicId)
        XCTAssertEqual(viewModel.selectedCategoryId, givenCategoryId)
        XCTAssertEqual(viewModel.selectedGlassId, givenGlassId)
    }
    
    func test_givenAlcoholicCategoryAndGlassIds_whenResetButtonIsTapped_thenAllIdsShouldBeNil() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        let givenAlcoholicId = "Alcoholic"
        let givenCategoryId = "Cocktail"
        let givenGlassId = "Wine Glass"
        
        // SUT
        let viewModel = FiltersViewModel()
       
        // When
        viewModel.onAlcoholicFilterViewTap(with: givenAlcoholicId)
        viewModel.onCategoryFilterViewTap(with: givenCategoryId)
        viewModel.onGlassFilterViewTap(with: givenGlassId)
        viewModel.onResetButtonTap()
        
        // Then
        XCTAssertNil(viewModel.selectedAlcoholicId)
        XCTAssertNil(viewModel.selectedCategoryId)
        XCTAssertNil(viewModel.selectedGlassId)
    }
    
    func test_givenFiltersScreenIsShown_whenFilterItemsAreFetched_thenIsLoadingShouldBeFalse() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        
        // SUT
        let viewModel = FiltersViewModel(cocktailService: mockCocktailsService)
       
        // When
        
        
        // Then
        wait()
        
        XCTAssertFalse(viewModel.isLoading)
    }
    
    private func wait() {
        let exp = expectation(description: "Wait for async")
        _ = XCTWaiter.wait(for: [exp], timeout: 1.0)
    }
}
