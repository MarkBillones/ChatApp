//
//  CategoryCollectionViewCell.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/24/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categriesButton: UIButton!
    
    static let identifier = "CategoryCollectionViewCell"
    
    func setButtonLabels(lblString: String){
        
        categriesButton.setTitle(lblString, for: .normal)
    }
}
