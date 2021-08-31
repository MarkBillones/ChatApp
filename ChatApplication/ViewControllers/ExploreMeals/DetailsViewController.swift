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
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(mealQueryID: mealId)
        configureImgage(mealQueryID: mealImageString)
        
        detailsTable.delegate = self
        detailsTable.dataSource = self
        
        mealNameLabel.text = mealName
        mealsImageView.image = UIImage(systemName: "photo.fill")
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
//                print("\(String(describing: jsonResult.meals.first))") //check firdt item results
//                print("count of search by ID: \(jsonResult.meals.count)")
                let instruct = jsonResult.meals.first?.strInstructions ?? "There is no Instructions"
                let ingredients1 = jsonResult.meals.first?.strIngredient1 ?? "none"
                let ingredients2 = jsonResult.meals.first?.strIngredient2 ?? "none"
                let ingredients3 = jsonResult.meals.first?.strIngredient3 ?? "none"
                let ingredients4 = jsonResult.meals.first?.strIngredient4 ?? "none"
                let ingredients5 = jsonResult.meals.first?.strIngredient5 ?? "none"
                let ingredients6 = jsonResult.meals.first?.strIngredient6 ?? "none"
                let measure1 = jsonResult.meals.first?.strMeasure1 ?? "none"
                let measure2 = jsonResult.meals.first?.strMeasure2 ?? "none"
                let measure3 = jsonResult.meals.first?.strMeasure3 ?? "none"
                let measure4 = jsonResult.meals.first?.strMeasure4 ?? "none"
                let measure5 = jsonResult.meals.first?.strMeasure5 ?? "none"
                let measure6 = jsonResult.meals.first?.strMeasure6 ?? "none"
                
                DispatchQueue.main.async {
                    self?.sections = [
                        Section(title: "Ingredients", sectionDetailText: "Hide Details", detailsText: [measure1, measure2, measure3, measure4, measure5, measure6, ""],
                                options: [ingredients1, ingredients2, ingredients3, ingredients4, ingredients5, ingredients6, ""]),
                        
                        Section(title: "Instructions", sectionDetailText: "Hide Details", detailsText: [""],
                                options: [instruct, ""]),
                    ]
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        
        if section.isOpened {
            return section.options.count
        }
        else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = sections[indexPath.section].title
            cell.detailTextLabel?.text = sections[indexPath.section].sectionDetailText
            
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
            cell.detailTextLabel?.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
            if sections[indexPath.section].isOpened == true {
                cell.detailTextLabel?.text = "Hide Details"
            }
            else { cell.detailTextLabel?.text = "Show Details" }
        }
        else {
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
            cell.detailTextLabel?.text = sections[indexPath.section].detailText[indexPath.row - 1]
            cell.textLabel?.numberOfLines = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //if index 0 is tapped in section it will collapse
            if indexPath.row == 0 {
                //expandable happens here, when tapped, revert the current bool
                sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
                tableView.reloadSections([indexPath.section], with: .none)
            }
        else {
            print("sub cell is tapped")
        }
    }
}


//model with properties for the collapsable table view
class Section {
    let title: String
    var sectionDetailText: String = ""
    let detailText: [String]
    let options: [String]
    var isOpened = false
    
    //initializer
    init(title: String, sectionDetailText: String, detailsText: [String], options: [String], isOpened: Bool = true){
        //constructors
        self.title = title
        self.sectionDetailText = sectionDetailText
        self.detailText = detailsText
        self.options = options
        self.isOpened = isOpened
    }
}
