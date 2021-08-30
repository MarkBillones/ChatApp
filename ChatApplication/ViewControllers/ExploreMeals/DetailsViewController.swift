//
//  DetailsViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit

//model with properties for the collapsable table view
class Section {
    let title: String
    let detailText: String
    let options: [String]
    var isOpened = false
    
    //initializer
    init(title: String, detailsText: String, options: [String], isOpened: Bool = false){
        //constructors
        self.title = title
        self.detailText = detailsText
        self.options = options
        self.isOpened = isOpened
    }
}

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
        
        sections = [
            Section(title: "Ingredients", detailsText: "Hide Details", options: [1,2,3].compactMap({return "Cell \($0)"})),
            Section(title: "Instructions", detailsText: "Hide Details", options: [1,2].compactMap({return "Cell \($0)"})),
            Section(title: "Sction 3", detailsText: "Hide Details", options: [1,2,3].compactMap({return "Cell \($0)"}))
        ]
        
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
                print("\(String(describing: jsonResult.meals.first))") // to check if i can get result when using that url
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
            cell.detailTextLabel?.text = sections[indexPath.section].detailText
            cell.detailTextLabel?.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
        }
        else {
            
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
            
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
