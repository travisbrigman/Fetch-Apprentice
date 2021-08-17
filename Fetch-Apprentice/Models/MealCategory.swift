//
//  MealCategory.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/13/21.
//

import Foundation
struct Categories: Codable {
    let categories: [MealCategory]
}

struct MealCategory: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
