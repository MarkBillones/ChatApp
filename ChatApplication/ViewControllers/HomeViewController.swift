//
//  HomeViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/17/21.
//

import UIKit

struct APIResponse: Codable {
    let meals: [ByCategory]
}

struct ByCategory: Codable {
    let idMeal: String
    let strMeal: String?
    let strMealThumb: String
}

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    //        "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    
    var meals: [ByCategory] = []
    var labelString = [ByCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon1 = UITabBarItem(title: "Meals", image: .init(systemName: "square.grid.2x2"), selectedImage: .init(systemName: "square.grid.2x2.fill"))
        self.tabBarItem = icon1
        
        fetchPhotos(query: "Beef")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if let text = searchBar.text {
            
            meals = [] //empty the meals array
            mealsCollectionView?.reloadData()
            fetchPhotos(query: text)
            
        }
    }
    
    func fetchPhotos(query: String) {
        
        let referenceURL = "\(searchByCategory)\(query)"
        
        guard let url = URL(string: referenceURL) else {
            return
        }
        //read the url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                //print("\(jsonResult.meals.first?.strMeal)") // to check if i can get result when using that url
                print("\(jsonResult.meals.count)")
                DispatchQueue.main.async {
                    self?.meals = jsonResult.meals
                    self?.mealsCollectionView.reloadData()
                }
                
            }catch {
                print("Error!")
            }
        }
        task.resume()
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mealsCollectionView {
            return meals.count
        }
        //row for the horizontal scroll
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.mealsCollectionView {
            
            //api call that download an image from a url
            let imageURLString = meals[indexPath.row].strMealThumb
            let lblString = meals[indexPath.row].strMeal
            
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealsCollectionViewCell.mealsCellIdentifier, for: indexPath) as? MealsCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            //access the configure function in the url
            cell.setLabels(lblString: lblString!)
            cell.configure(with: imageURLString)
            
            cell.designCell()
            
            return cell
            
        } else {
            
            let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealsCollectionViewCell", for: indexPath) as! MealsCollectionViewCell
            categoriesCell.designCellTwo()
            
            return categoriesCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.mealsCollectionView {
            
            let size = (collectionView.frame.size.width - 10) / 2
            
            return CGSize(width: size, height: size + 50)
        }
        
        let size = (collectionView.frame.size.width ) / 2
        
        return CGSize(width: size - 70, height: 50 ) //size = 187
    }
    
}

extension UIView {
    
    func designCell() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    }
    
    func designCellTwo() {
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    }
}
