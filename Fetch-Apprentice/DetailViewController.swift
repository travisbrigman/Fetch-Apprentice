//
//  DetailViewController.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/14/21.
//

import UIKit

class DetailViewController: UIViewController {
    let dataProvider = Provider()
    var detailItem: Meal?
    let urlBase = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var mealRecipe = [MealRecipe]()
    @IBOutlet weak var instructions: UILabel!
    
      
    func loadDataIntoView() {
        instructions.text = mealRecipe[0].strInstructions
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }
        let urlString = urlBase + detailItem.idMeal
        
        dataProvider.getMealRecipe(query: urlString) { [weak self] result in
            switch result {
            case .success(let results):
                self?.mealRecipe = results.meals
                self?.loadDataIntoView()
//                DispatchQueue.main.async {
//                    self?.view.reloadData()
//                }
                
                
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
