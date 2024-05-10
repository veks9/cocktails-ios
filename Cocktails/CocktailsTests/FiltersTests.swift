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
    
    func test_givenAlcoholicCategoryAndGlassIds_whenAlcoholicCategoryAndGlassIdsAreAssigned_thenResetButtonAndFloatingButtonShouldBeEnabled() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        let givenAlcoholicId = "Alcoholic"
        let givenCategoryId = "Cocktail"
        let givenGlassId = "Wine Glass"
        
        // SUT
        let viewModel = FiltersViewModel(cocktailService: mockCocktailsService)
       
        // When
        viewModel.onAlcoholicFilterViewTap(with: givenAlcoholicId)
        viewModel.onCategoryFilterViewTap(with: givenCategoryId)
        viewModel.onGlassFilterViewTap(with: givenGlassId)
        
        // Then
        XCTAssertFalse(viewModel.isResetButtonDisabled)
        XCTAssertFalse(viewModel.isFloatingButtonDisabled)
    }
    
    func test_givenAlcoholicCategoryAndGlassIds_whenResetButtonIsTapped_thenResetButtonAndFloatingButtonShouldBeDisabled() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        let givenAlcoholicId = "Alcoholic"
        let givenCategoryId = "Cocktail"
        let givenGlassId = "Wine Glass"
        
        // SUT
        let viewModel = FiltersViewModel(cocktailService: mockCocktailsService)
       
        // When
        viewModel.onAlcoholicFilterViewTap(with: givenAlcoholicId)
        viewModel.onCategoryFilterViewTap(with: givenCategoryId)
        viewModel.onGlassFilterViewTap(with: givenGlassId)
        viewModel.onResetButtonTap()
        
        // Then
        XCTAssertTrue(viewModel.isResetButtonDisabled)
        XCTAssertTrue(viewModel.isFloatingButtonDisabled)
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
