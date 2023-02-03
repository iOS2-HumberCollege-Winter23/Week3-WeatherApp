//
//  SearchTableViewController.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-01-27.
//

import UIKit

protocol SearchingDelegate {
    func searchDifFinishWithASelectedCity(city : City);
    func searchDidCancel();
}

class SearchTableViewController: UITableViewController ,
                                 UISearchBarDelegate ,
                                    NetworkingDelegate
{
    func networkingDidFinishWithResult(allCities: [String]) {
        
    }
    
   
    var delegate : SearchingDelegate?
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var citiesNames = [City]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as! AppDelegate).num = 90
//
//        DispatchQueue.init(label: "MyQ").async {
//            // code to run in bg thread
//
//            DispatchQueue.main.async {
//                // do any thing related to UI in main thread
//            }
//        }
//        searchBar.delegate = self
        NetworkingService.shared.delegate = self
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(citiesNames[indexPath.row].cityName)  \(citiesNames[indexPath.row].countryName )"

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        activityIndicator.isHidden = false
        if searchText.count < 3 {
            self.citiesNames = [City]()
            self.tableView.reloadData()
        }
        if searchText.count >= 3 { // 1
            activityIndicator.isHidden = false
                //  NetworkingService.shared.getData(searchText: searchText)
     
            NetworkingService.shared.getData2(fullurl: "http://gd.geobytes.com/AutoCompleteCity?&q=" + searchText) { result in
                switch result{
                case .failure(let error):
                    print(error)
                    
                case .success(let data):
                    let result : [City] =  JsonService.shared.parseJson(data: data)
                    DispatchQueue.main.async {
                        self.citiesNames = result
                        self.tableView.reloadData()
                        self.activityIndicator.isHidden = true

                
                }
                }
            
            }
        }
        
    }
    
    
    func networkingDidFinishWithError() {
        // no thing to do
        citiesNames = [City]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func networkingDidFinishWithResult(allCities: [City]) {
        
        DispatchQueue.main.async {
            self.citiesNames = allCities
            self.tableView.reloadData()
            self.activityIndicator.isHidden = true

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCity = citiesNames[indexPath.row]
        delegate?.searchDifFinishWithASelectedCity(city: selectedCity)
        navigationController?.popViewController(animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
