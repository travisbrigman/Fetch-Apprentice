//
//  Fetch_ApprenticeTests.swift
//  Fetch-ApprenticeTests
//
//  Created by Travis Brigman on 8/13/21.
//

@testable import Fetch_Apprentice
import XCTest

class Fetch_ApprenticeTests: XCTestCase {
    let tvc = TableViewController()
    let dvc = DetailViewController()
    let provider = Provider()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCategorysCallCompletes() throws {
        let urlString: String = "https://www.themealdb.com/api/json/v1/1/categories.php"
        var categories: [MealCategory] = []
        let promise = expectation(description: "Status code: 200")
        provider.getCategoryResults(query: urlString) { [weak self] result in
            switch result {
            case .success(let results):
                categories = results.categories
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                print(error)
            }
        }

        wait(for: [promise], timeout: 5)
        XCTAssertEqual(categories.count, 14)
    }

    func testGetMealsInCategorysCallCompletes() throws {
        let urlString: String = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"
        var meals = [Meal]()
        let promise = expectation(description: "Status code: 200")
        provider.getMealsInCategoryResults(query: urlString) { [weak self] result in
            switch result {
            case .success(let results):
                meals = results.meals
                promise.fulfill()
            case .failure(let error):
                XCTFail("🚨Error: \(error.localizedDescription)")
                print(error)
            }
        }

        wait(for: [promise], timeout: 10)
        XCTAssertGreaterThan(meals.count, 0)
    }

    func testGetMealRecipeCallCompletes() throws {
        let urlString: String = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772"
        let promise = expectation(description: "Status code: 200")
        provider.getMealRecipe(query: urlString) { [weak self] result in
            switch result {
            case .success:
                promise.fulfill()
            case .failure(let error):
                XCTFail("🚨Error: \(error.localizedDescription)")
                print(error)
            }
        }

        wait(for: [promise], timeout: 5)
    }

    func SKIPtestGetIngredients() throws {
        let mealRecipe = MealRecipe(idMeal: "52772", strMeal: "Teriyaki Chicken Casserole", strDrinkAlternate: nil, strCategory: "Chicken", strArea: "Japanese", strInstructions: "Preheat oven to 350\u{00b0} F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, \u{00bd} cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!", strMealThumb: "https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/wvpsxx1468256321.jpg", strTags: "Meat, Casserole", strYoutube: "https:\\/\\/www.youtube.com\\/watch?v=4aZr5hZXP_s", strIngredient1: "soy sauce", strIngredient2: "water", strIngredient3: "brown sugar", strIngredient4: "ground ginger", strIngredient5: "minced garlic", strIngredient6: "cornstarch", strIngredient7: "chicken breasts", strIngredient8: "stir-fry vegetables", strIngredient9: "brown rice", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: nil, strIngredient15: "", strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "3\\/4 cup", strMeasure2: "1\\/2 cup", strMeasure3: "1\\/4 cup", strMeasure4: "1\\/2 teaspoon", strMeasure5: "1\\/2 teaspoon", strMeasure6: "4 tablespoons", strMeasure7: "2", strMeasure8: "1 (12 oz.)", strMeasure9: "3 cups", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil)
        var ingredientNames = [String]()
        var ingredientMeasurements = [String]()

        dvc.getIngredients()
        XCTAssertEqual(ingredientNames.count, 9)
    }
}
