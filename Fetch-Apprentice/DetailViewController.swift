//
//  DetailViewController.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/14/21.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate {
    
    let dataProvider = Provider()
    var detailItem: Meal?
    let urlBase = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var mealRecipe: MealRecipe?
    @IBOutlet var ingredientTable: UITableView!
    @IBOutlet var instructions: UILabel!
    
    var ingredientNames = [String]()
    var ingredientMeasurements = [String]()

    
    func loadDataIntoView() {
        guard let mealRecipe = mealRecipe else { return }
        DispatchQueue.main.async {
            self.instructions.text = mealRecipe.strInstructions
            self.ingredientTable.reloadData()
        }
    }
    
    func getIngredients() {
        guard let mealRecipe = mealRecipe else { return }
        let mirror = Mirror(reflecting: mealRecipe)
        var foundIngredients = [String?]()
        var foundMeasurements = [String?]()

        for case let (label?, value?) in mirror
            .children.map({ ($0.label, $0.value) }) {
            if label.hasPrefix("strIngredient") {
                foundIngredients.append(value as? String)
            }
            if label.hasPrefix("strMeasure") {
                foundMeasurements.append(value as? String)
            }
        }
        var stringIngredients = foundIngredients.compactMap{ $0 }
        
        for (index, item) in stringIngredients.enumerated().reversed() {
            if item.isEmpty {
                stringIngredients.remove(at: index)
            }
        }
        var stringMeasurements = foundMeasurements.compactMap{ $0 }
        
        for (index, item) in stringMeasurements.enumerated().reversed() {
                if item.isEmpty {
                    stringMeasurements.remove(at: index)
                }
        }
        ingredientNames = stringIngredients
        ingredientMeasurements = stringMeasurements
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }
        let urlString = urlBase + detailItem.idMeal
        title = detailItem.strMeal
        ingredientTable.dataSource = self
        
        dataProvider.getMealRecipe(query: urlString) { [weak self] result in
            switch result {
            case .success(let results):
                self?.mealRecipe = results.meals[0]
                self?.loadDataIntoView()
                self?.getIngredients()
                
            case .failure(let error):
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(ac, animated: true)
                }
                print(error)
            }
        }
    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleIngredientName = ingredientNames[indexPath.row]
        let singleIngredientMeasurement = ingredientMeasurements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = singleIngredientName
        cell.detailTextLabel?.text = singleIngredientMeasurement
        
        return cell
    }
}
