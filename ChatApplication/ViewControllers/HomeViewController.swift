//
//  HomeViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/17/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon1 = UITabBarItem(title: "Meals", image: .init(systemName: "square.grid.2x2"), selectedImage: .init(systemName: "square.grid.2x2.fill"))
        
        self.tabBarItem = icon1
        
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mealsCollectionView {
            return 10
        }
        //row for the horizontal scroll
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.mealsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealsCollectionViewCell", for: indexPath) as! MealsCollectionViewCell
            cell.designCell()
            
            return cell
            
        }else {
            
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
