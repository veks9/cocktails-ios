//
//  Localization.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import Foundation

enum Localization: String {
    
    // MARK: - Common
    
    case relativeDateYearAgo = "relative_date_year_ago"
    case relativeDateYearsAgo = "relative_date_years_ago"
    case relativeDateThisYear = "relative_date_this_year"
    case relativeDateThisMonth = "relative_date_this_month"
    case relativeDateThisWeek = "relative_date_this_week"
    case relativeDateToday = "relative_date_today"
    case searchBarPlaceholder = "search_bar_placeholder"
    case searchBarFocusedPlaceholder = "search_bar_focused_placeholder"
    case loadingViewTitle = "loading_view_title"
    case errorTitle = "error_title"
    case errorTryAgainButtonTitle = "error_try_again_button_title"
    
    // MARK: - Home
    
    case homeFloatingButtonTitle = "home_floating_button_title"
    
    // MARK: - Cocktail Details
    
    case cocktailDetailsIngredientsSectionTitle = "cocktail_details_ingredients_section_title"
    case cocktailDetailsDirectionsSectionTitle = "cocktail_details_directions_section_title"
    case cocktailDetailsDirectionsLastModifiedTitle = "cocktail_details_directions_last_modified_title"
    
    // MARK: - Filters
    
    case filtersAlcoholicSectionTitle = "filters_alcoholic_section_title"
    case filtersGlassSectionTitle = "filters_glass_section_title"
    case filtersCategorySectionTitle = "filters_category_section_title"
    case filtersNavigationTitle = "filters_navigation_title"
    case filtersTrailingButtonTitle = "filters_trailing_button_title"
    case filtersFloatingButtonTitle = "filters_floating_button_title"
    
    // MARK: - Filter Results
    
    case filterResultsNavigationTitle = "filter_results_navigation_title"
}

// MARK: - Internal functions

extension Localization {
    func localized(_ args: CVarArg...) -> String {
        rawValue.localized(args)
    }
}
