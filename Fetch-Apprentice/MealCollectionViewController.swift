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
        title = categoryName
        
        let urlString = urlBase + detailItem!.strCategory
        
        dataProvider.getMealsInCategoryResults(query: urlString) { [weak self] result in
            switch result {
            case .success(let results):
                self?.mealsInCategory = results.meals
               
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


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


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
 

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
