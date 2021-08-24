//
//  MealsCollectionViewCell.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/21/21.
//

import UIKit

class MealsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mealsDescriptionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    static let mealsCellIdentifier = "MealsCollectionViewCell"
    
    
    func setLabels(lblString: String){
        mealsDescriptionLabel.text = lblString
    }
    
    func configure(with urlString: String){
        
        guard
            let url = URL(string: urlString)
        else {
            return
        }
        // networking call to download the image data for the url
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //run in main thread image is part of ui object
            DispatchQueue.main.async {
                let image = UIImage (data: data)
                self?.imageView.image = image
            }
        }.resume()
    }
}
