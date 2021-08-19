//
//  MealRecipe.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/14/21.
//

import Foundation

struct SingleMeal: Decodable {
    let meals: [MealRecipe]
}
/*
extension MealRecipe {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let mealId = try container.decode(String.self, forKey: .idMeal)
        let mealName = try container.decode(String.self, forKey: .strMeal)
        let drink = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        let category = try container.decodeIfPresent(String.self, forKey: .strCategory)
        let regionOfOrigin = try container.decodeIfPresent(String.self, forKey: .strArea)
        let instructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        let imageURL = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        let tags = try container.decodeIfPresent(String.self, forKey: .strTags)
        let youTubeLink = try container.decodeIfPresent(String.self, forKey: .strYoutube)

        let ingredient1 = try container.decodeIfPresent(String.self, forKey: .strIngredient1)
        let ingredient2 = try container.decodeIfPresent(String.self, forKey: .strIngredient2)
        let ingredient3 = try container.decodeIfPresent(String.self, forKey: .strIngredient3)
        let ingredient4 = try container.decodeIfPresent(String.self, forKey: .strIngredient4)
        let ingredient5 = try container.decodeIfPresent(String.self, forKey: .strIngredient5)
        let ingredient6 = try container.decodeIfPresent(String.self, forKey: .strIngredient6)
        let ingredient7 = try container.decodeIfPresent(String.self, forKey: .strIngredient7)
        let ingredient8 = try container.decodeIfPresent(String.self, forKey: .strIngredient8)
        let ingredient9 = try container.decodeIfPresent(String.self, forKey: .strIngredient9)
        let ingredient10 = try container.decodeIfPresent(String.self, forKey: .strIngredient10)
        let ingredient11 = try container.decodeIfPresent(String.self, forKey: .strIngredient11)
        let ingredient12 = try container.decodeIfPresent(String.self, forKey: .strIngredient12)
        let ingredient13 = try container.decodeIfPresent(String.self, forKey: .strIngredient13)
        let ingredient14 = try container.decodeIfPresent(String.self, forKey: .strIngredient14)
        let ingredient15 = try container.decodeIfPresent(String.self, forKey: .strIngredient15)
        let ingredient16 = try container.decodeIfPresent(String.self, forKey: .strIngredient16)
        let ingredient17 = try container.decodeIfPresent(String.self, forKey: .strIngredient17)
        let ingredient18 = try container.decodeIfPresent(String.self, forKey: .strIngredient18)
        let ingredient19 = try container.decodeIfPresent(String.self, forKey: .strIngredient19)
        let ingredient20 = try container.decodeIfPresent(String.self, forKey: .strIngredient20)

        let measurement1 = try container.decodeIfPresent(String.self, forKey: .strMeasure1)
        let measurement2 = try container.decodeIfPresent(String.self, forKey: .strMeasure2)
        let measurement3 = try container.decodeIfPresent(String.self, forKey: .strMeasure3)
        let measurement4 = try container.decodeIfPresent(String.self, forKey: .strMeasure4)
        let measurement5 = try container.decodeIfPresent(String.self, forKey: .strMeasure5)
        let measurement6 = try container.decodeIfPresent(String.self, forKey: .strMeasure6)
        let measurement7 = try container.decodeIfPresent(String.self, forKey: .strMeasure7)
        let measurement8 = try container.decodeIfPresent(String.self, forKey: .strMeasure8)
        let measurement9 = try container.decodeIfPresent(String.self, forKey: .strMeasure9)
        let measurement10 = try container.decodeIfPresent(String.self, forKey: .strMeasure10)
        let measurement11 = try container.decodeIfPresent(String.self, forKey: .strMeasure11)
        let measurement12 = try container.decodeIfPresent(String.self, forKey: .strMeasure12)
        let measurement13 = try container.decodeIfPresent(String.self, forKey: .strMeasure13)
        let measurement14 = try container.decodeIfPresent(String.self, forKey: .strMeasure14)
        let measurement15 = try container.decodeIfPresent(String.self, forKey: .strMeasure15)
        let measurement16 = try container.decodeIfPresent(String.self, forKey: .strMeasure16)
        let measurement17 = try container.decodeIfPresent(String.self, forKey: .strMeasure17)
        let measurement18 = try container.decodeIfPresent(String.self, forKey: .strMeasure18)
        let measurement19 = try container.decodeIfPresent(String.self, forKey: .strMeasure19)
        let measurement20 = try container.decodeIfPresent(String.self, forKey: .strMeasure20)

        self.init(idMeal: mealId,
                  strMeal: mealName,
                  strDrinkAlternate: drink,
                  strCategory: category,
                  strArea: regionOfOrigin,
                  strInstructions: instructions,
                  strMealThumb: imageURL,
                  strTags: tags,
                  strYoutube: youTubeLink,
                  strIngredient1: ingredient1,
                  strIngredient2: ingredient2,
                  strIngredient3: ingredient3,
                  strIngredient4: ingredient4,
                  strIngredient5: ingredient5,
                  strIngredient6: ingredient6,
                  strIngredient7: ingredient7,
                  strIngredient8: ingredient8,
                  strIngredient9: ingredient9,
                  strIngredient10: ingredient10,
                  strIngredient11: ingredient11,
                  strIngredient12: ingredient12,
                  strIngredient13: ingredient13,
                  strIngredient14: ingredient14,
                  strIngredient15: ingredient15,
                  strIngredient16: ingredient16,
                  strIngredient17: ingredient17,
                  strIngredient18: ingredient18,
                  strIngredient19: ingredient19,
                  strIngredient20: ingredient20,

                  strMeasure1: measurement1,
                  strMeasure2: measurement2,
                  strMeasure3: measurement3,
                  strMeasure4: measurement4,
                  strMeasure5: measurement5,
                  strMeasure6: measurement6,
                  strMeasure7: measurement7,
                  strMeasure8: measurement8,
                  strMeasure9: measurement9,
                  strMeasure10: measurement10,
                  strMeasure11: measurement11,
                  strMeasure12: measurement12,
                  strMeasure13: measurement13,
                  strMeasure14: measurement14,
                  strMeasure15: measurement15,
                  strMeasure16: measurement16,
                  strMeasure17: measurement17,
                  strMeasure18: measurement18,
                  strMeasure19: measurement19,
                  strMeasure20: measurement20)
    }

    var asDictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map { (label: String?, value: Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }.compactMap { $0 })
        return dict
    }
}
 */

struct MealRecipe: Decodable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?

    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
/*
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
 */
}
