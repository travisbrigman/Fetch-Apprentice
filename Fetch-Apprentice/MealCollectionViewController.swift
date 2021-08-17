//
//  MealCollectionViewController.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/13/21.
//

import UIKit

private let reuseIdentifier = "MealItem"

class MealCollectionViewController: UICollectionViewController {
    let dataProvider = Provider()
    var detailItem: MealCategory?
    var categoryName: String = ""
    let urlBase = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    var mealsInCategory = [Meal]()

    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        title = detailItem?.strCategory
        
        let urlString = urlBase + detailItem!.strCategory
        
        dataProvider.getMealsInCategoryResults(query: urlString) { [weak self] result in
            switch result {
            case .success(let results):
                self?.mealsInCategory = results.meals.sorted { $0.strMeal.lowercased() < $1.strMeal.lowercased() }
               
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealsInCategory.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealItem", for: indexPath) as! MealPictureCell
        
        let singleMeal = mealsInCategory[indexPath.item]
        
        cell.mealImage.image = fetchImage(photoURL: singleMeal.strMealThumb)
        cell.mealImage.contentMode = .scaleAspectFit
        cell.mealImage.clipsToBounds = true
        cell.mealImage.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.mealImage.layer.borderWidth = 2
        cell.mealImage.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        cell.mealName.text = singleMeal.strMeal
    
        return cell
    }
  
    func fetchImage(photoURL: String?) -> UIImage {
        guard let imageURL = URL(string: photoURL ?? "no URL found") else { return
            UIImage()
        }
         
        let imageData: Data = try! Data(contentsOf: imageURL)
         
        guard let image = UIImage(data: imageData) else { return UIImage() }
         
        return image
    }
 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleMeal = mealsInCategory[indexPath.item]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
            vc.detailItem = singleMeal
        }
    }
}
