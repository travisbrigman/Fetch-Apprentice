//
//  ViewController.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/13/21.
//

import UIKit

class TableViewController: UITableViewController {
    var urlString: String = "https://www.themealdb.com/api/json/v1/1/categories.php"
    
    let dataProvider = Provider()
    var categories = [MealCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meal Categories"
        dataProvider.getCategoryResults(query: urlString) { [weak self] result in
            switch result {
            case .success(let results):
                self?.categories = results.categories.sorted { $0.strCategory.lowercased() < $1.strCategory.lowercased() }
               
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
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

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleCategory = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCategory", for: indexPath)
        cell.textLabel?.text = singleCategory.strCategory
        
        return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MealsInCategory") as? MealCollectionViewController {
            let selectedCategory = categories[indexPath.row]
            vc.detailItem = selectedCategory
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
