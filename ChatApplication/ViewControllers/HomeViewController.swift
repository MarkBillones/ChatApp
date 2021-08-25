//
//  HomeViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/17/21.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    
    var meals: [ByCategory] = []
    var categories: [CategoryList] = []
    var labelString = [ByCategory]()
    var buttonString = [CategoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItemsConfiguration()
        fetchListOfCategory()
        fetchPhotos(query: "Beef")
        categoryCollectionView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if let text = searchBar.text {
            
            meals = [] //empty the meals array
            mealsCollectionView?.reloadData()
            fetchPhotos(query: text)
            
        }
    }
    
    func fetchListOfCategory() {
        
        let referenceURLForList = "\(listOfCategory)"
        
        guard let url = URL(string: referenceURLForList) else {
            return
        }
        //read the url
        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let datas = data, error == nil else {
                print("error in URLSession")
                return
            }
            
            do {
                let jsonResults = try JSONDecoder().decode(CategoriesAPIResponse.self, from: datas)
                //print("List of categories: \(jsonResults.categories.first?.strCategory)") // to check if i can get result when using that url
                print("how many results: \(jsonResults.categories.count)")
                
                DispatchQueue.main.async {
                    self?.categories = jsonResults.categories
                    self?.categoryCollectionView.reloadData()
                }

            }catch {
                print("Error!")
            }
        }.resume()
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
                let jsonResult = try JSONDecoder().decode(MealsAPIResponse.self, from: data)
                //print("\(jsonResult.meals.first?.strMeal)") // to check if i can get result when using that url
                print("count of meals: \(jsonResult.meals.count)")
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
    
    fileprivate func tabBarItemsConfiguration() {
        let icon1 = UITabBarItem(title: "Meals", image: .init(systemName: "square.grid.2x2"), selectedImage: .init(systemName: "square.grid.2x2.fill"))
        self.tabBarItem = icon1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
//        sender.backgroundColor = sender.backgroundColor == UIColor.green ? UIColor.green : UIColor.white
        
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
            
            meals = [] //empty the meals array
            mealsCollectionView?.reloadData()
            sender.backgroundColor = UIColor.green
            fetchPhotos(query: buttonTitle)
            
          }

    }
    
    
    // TODO: see all
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mealsCollectionView {
            return meals.count
        }
        
        if collectionView == categoryCollectionView {
            return categories.count
        }
        
        return 2
        
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
            
            cell.shareButton.softCornerButton(sizeCR: 5)
            cell.designCell()
            
            return cell
            
        } else {
            
            let categoryString = categories[indexPath.row].strCategory
            
            guard
                let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell
            else {
                return UICollectionViewCell()
                
            }
            
            categoriesCell.designCellTwo()
            categoriesCell.categriesButton.designButton()
            
            categoriesCell.setButtonLabels(lblString: categoryString!)
            
            return categoriesCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.mealsCollectionView {
            
            let size = (collectionView.frame.size.width - 10) / 2
            
            return CGSize(width: size, height: size + 50)
        }
        
        if collectionView == categoryCollectionView {
            
            let size = (collectionView.frame.size.width ) / 2
            
            return CGSize(width: size - 70, height: 50 ) //size = 187
        }
        
        return CGSize(width: 200, height: 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MealsCollectionViewCell {
            print(indexPath.row)
            print(#function)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == self.mealsCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                print(#function)
                cell.categriesButton.designButtonSelected()
            }
        }
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

extension UIButton {
    
    func designButton() {
        
        self.tintColor = .black
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func designButtonSelected() {
        
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
    func softCornerButton(sizeCR: CGFloat) {
        
        self.layer.cornerRadius = sizeCR
    }
}
