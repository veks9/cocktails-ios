//
//  HomeTests.swift
//  HomeTests
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import XCTest
import Combine
@testable import Cocktails

final class HomeTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_givenHomeScreenIsShown_whenSearchQueryIsEmptyAndSearchBarNotFocused_thenAllCocktailsShouldBeShown() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        mockCocktailsService.mockSearchCocktailsResponse = Model.Response(
            data: [
                Model.Drink(
                    id: "0",
                    name: "Martini"
                ),
                Model.Drink(
                    id: "1",
                    name: "Moscow Mule"
                ),
                Model.Drink(
                    id: "2",
                    name: "Mai Tai"
                )
            ]
        )
        
        // SUT
        let viewModel = HomeViewModel(cocktailService: mockCocktailsService)
       
        // When
        viewModel.searchText = ""
        viewModel.onSearchBarFocusChange(false)
        
        // Then
        wait()
        
        XCTAssertEqual(viewModel.cocktailViewModels.count, (mockCocktailsService.mockSearchCocktailsResponse?.data ?? []).count)
        XCTAssertEqual(viewModel.cocktailViewModels.first?.title, (mockCocktailsService.mockSearchCocktailsResponse?.data ?? []).first?.name)
    }
    
    func test_givenHomeScreenIsShown_whenSearchQueryIsEmptyAndSearchBarIsFocused_thenNoCocktailsShouldBeShown() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        mockCocktailsService.mockSearchCocktailsResponse = Model.Response(
            data: [
                Model.Drink(
                    id: "0",
                    name: "Martini"
                ),
                Model.Drink(
                    id: "1",
                    name: "Moscow Mule"
                ),
                Model.Drink(
                    id: "2",
                    name: "Mai Tai"
                )
            ]
        )
        
        // SUT
        let viewModel = HomeViewModel(cocktailService: mockCocktailsService)
       
        // When
        viewModel.searchText = ""
        viewModel.onSearchBarFocusChange(true)
        
        // Then
        wait()
        
        XCTAssertEqual(viewModel.cocktailViewModels.count, 0)
    }
    
    func test_givenHomeScreenIsShown_whenCocktailItemsAreFetched_thenIsLoadingShouldBeFalse() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        mockCocktailsService.mockSearchCocktailsResponse = Model.Response(
            data: [
                Model.Drink(
                    id: "0",
                    name: "Martini"
                ),
                Model.Drink(
                    id: "1",
                    name: "Moscow Mule"
                ),
                Model.Drink(
                    id: "2",
                    name: "Mai Tai"
                )
            ]
        )
        
        // SUT
        let viewModel = HomeViewModel(cocktailService: mockCocktailsService)
       
        // When
        
        
        // Then
        wait()
        
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_givenHomeScreenIsShown_whenSearchTextIsEmptyAndIsNotFocused_thenFilterButtonShouldBeShown() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        mockCocktailsService.mockSearchCocktailsResponse = Model.Response(
            data: [
                Model.Drink(
                    id: "0",
                    name: "Martini"
                ),
                Model.Drink(
                    id: "1",
                    name: "Moscow Mule"
                ),
                Model.Drink(
                    id: "2",
                    name: "Mai Tai"
                )
            ]
        )
        
        // SUT
        let viewModel = HomeViewModel(cocktailService: mockCocktailsService)
       
        // When
        viewModel.searchText = ""
        viewModel.onSearchBarFocusChange(true)
        
        // Then
        wait()
        
        XCTAssertTrue(viewModel.isFilterButtonShown)
    }
    
    func test_givenHomeScreenIsShown_whenSearchTextIsEmptyAndIsFocused_thenFilterButtonShouldNotBeShown() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        mockCocktailsService.mockSearchCocktailsResponse = Model.Response(
            data: [
                Model.Drink(
                    id: "0",
                    name: "Martini"
                ),
                Model.Drink(
                    id: "1",
                    name: "Moscow Mule"
                ),
                Model.Drink(
                    id: "2",
                    name: "Mai Tai"
                )
            ]
        )
        
        // SUT
        let viewModel = HomeViewModel(cocktailService: mockCocktailsService)
       
        // When
        viewModel.searchText = ""
        viewModel.onSearchBarFocusChange(true)
        
        // Then
        wait()
        
        XCTAssertFalse(viewModel.isFilterButtonShown)
    }
    
    func test_givenHomeScreenIsShown_whenSearchTextIsNotEmptyAndIsNotFocused_thenFilterButtonShouldNotBeShown() throws {
        // Given
        let mockCocktailsService = MockCocktailService()
        mockCocktailsService.mockSearchCocktailsResponse = Model.Response(
            data: [
                Model.Drink(
                    id: "0",
                    name: "Martini"
                ),
                Model.Drink(
                    id: "1",
                    name: "Moscow Mule"
                ),
                Model.Drink(
                    id: "2",
                    name: "Mai Tai"
                )
            ]
        )
        
        // SUT
        let viewModel = HomeViewModel(cocktailService: mockCocktailsService)
       
        // When
        viewModel.searchText = "Ma"
        viewModel.onSearchBarFocusChange(false)
        
        // Then
        wait()
        
        XCTAssertFalse(viewModel.isFilterButtonShown)
    }
    
    private func wait() {
        let exp = expectation(description: "Wait for async")
        _ = XCTWaiter.wait(for: [exp], timeout: 1.0)
    }
}
