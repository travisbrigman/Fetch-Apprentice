//
//  Meal.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/13/21.
//

import Foundation

// MARK: - Meals

struct Meals: Codable {
    let meals: [Meal]
}

// MARK: - Meal

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
