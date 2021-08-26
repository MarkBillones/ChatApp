//
//  DetailsViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit

class DetailsViewController: UIViewController{

    @IBOutlet var detailsTable: UITableView!
    @IBOutlet weak var mealsImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    var mealId: String!
    var mealName: String!
    var mealImageString: String!
    
    private var meals: [lookupID] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(mealQueryID: mealId)
        configureImgage(mealQueryID: mealImageString)
        
        detailsTable.delegate = self
        detailsTable.dataSource = self
        
        mealsImageView.image = UIImage(systemName: "photo.fill")
        mealNameLabel.text = mealName
        
    }
    
    func setMealName(lblString: String){
        mealNameLabel.text = lblString
    }
    
    // this is to fetch the api: Lookup full meal details by id can fetch the other info
    func configure(mealQueryID: String) {

        let urlString = "\(lookUpByID)\(mealQueryID)"

        guard let url = URL(string: urlString) else {
            return
        }
        //read the url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let jsonResult = try JSONDecoder().decode(lookupAPIResponce.self, from: data)
                //print("\(jsonResult.meals.first?.strMeal)") // to check if i can get result when using that url
                print("count of search by ID: \(jsonResult.meals.count)")
                DispatchQueue.main.async {
                    
                    self?.meals = jsonResult.meals
                    self?.detailsTable.reloadData()
                }

            }catch {
                print("Error!")
            }
        }
        task.resume()
    }
    
    //used to download the same photo from the meals collection view cell
    func configureImgage(mealQueryID: String){
        
        guard let url = URL(string: mealQueryID)
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
                let image = UIImage(data: data)
                self?.mealsImageView.image = image
            }
        }.resume()
    }

}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableView.numberOfSections
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Ingredients"
        cell.detailTextLabel?.text = "Measurements"
        return cell
        
    }
}
