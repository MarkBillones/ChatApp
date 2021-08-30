//
//  AllCategorieViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit

class AllCategorieViewController: UIViewController {
    
    @IBOutlet weak var allCategoryCollectionView: UICollectionView!
    
    var temp: String = ""
    var delegate: mealsDataDelegate? = nil
    var categories: [CategoryList] = []
    var buttonString = [CategoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchallCategory()
    }
    
    
    func fetchallCategory() {
        
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
                    self?.allCategoryCollectionView.reloadData()
                }

            }catch {
                print("Error!")
            }
        }.resume()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        let selectedCategory = temp
        
        self.delegate?.sendValue(selectedCategory: selectedCategory)
        // navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

extension AllCategorieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return categories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //api call that download an image from a url
        let imageURLString = categories[indexPath.row].strCategoryThumb
        let lblString = categories[indexPath.row].strCategory
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCategoriesCollectionViewCell.categoriesCellIdentifier, for: indexPath) as? AllCategoriesCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        //access the configure function in the url
        cell.setLabels(lblString: lblString!)
        cell.configure(with: imageURLString)
        temp = cell.cat
        
        cell.designCell()
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let size = (collectionView.frame.size.width - 40) / 2
        
        return CGSize(width: size, height: size + 50)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AllCategoriesCollectionViewCell {
            
            
            let currentText = cell.categoriesDescriptionLabel.text
            temp = currentText ?? "No Title"
            print(temp)
            print(indexPath.row)
            print(#function)
        }
    }
    
}
