//
//  ViewController.swift
//  NYCSchools
//
//  Created by Paolo Cifuentes on 03/21/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var schoolsTableView: UITableView! {
        didSet {
            self.schoolsTableView.tableFooterView = UIView()
            self.schoolsTableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYC School"
        schoolsTableView.delegate = self
        schoolsTableView.dataSource = self 
        // Do any additional setup after loading the view.
        fetch()
    }
    var schoolsDataSource: Highschools? {
        didSet {
            DispatchQueue.main.async {
                self.schoolsTableView.reloadData()
            }
        }
    }
    var schools: [School]? {
        didSet {
            DispatchQueue.main.async {
                self.schoolsTableView.reloadData()
            }
        }
    }
    var currentIndex = 0
    
    // fetching the data from the URL
    func fetch() {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard let unwrappedData = data else {
                return
            }
            switch response.statusCode {
            case 200...299:
                do {
                    self.schools = try JSONDecoder().decode([School].self, from: unwrappedData)
                } catch {
                    print(error.localizedDescription)
                }
            default:
                break
            }

        }.resume()
    }

}

//extension of the tableviewcontroller so that we can fill the data source (NYC Schools).
extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schools?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
        
        let school: School = (self.schools?[indexPath.row] as? School)!
        reusableCell?.textLabel?.text = school.schoolName
        
        reusableCell?.textLabel?.textColor = .darkGray
        
        return reusableCell!
    }
}

//extension for whne a row is selected we segue into the next view.
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentIndex = indexPath.row
        let sb = storyboard?.instantiateViewController(withIdentifier: "DisplayInfoViewController") as! DisplayInfoViewController
        sb.school = schools?[indexPath.row]
        self.navigationController?.pushViewController(sb, animated: true)
    }
}

//If I had more time I would've liked to pay more attention to the UI details.
//I went with an MVC pattern to keep it simple rather than overcomplicate it, however, I would've  opted for an MVVM pattern to have more separations and easier testability if I had more time.
