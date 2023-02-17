//
//  CitiesTableViewController.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-01-27.
//

import UIKit
import CloudKit
import CoreData

class CitiesTableViewController: UITableViewController , SearchingDelegate,
NSFetchedResultsControllerDelegate
{

   // var citiesFromDB = [CityDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // citiesFromDB = CoreDataService.shared.getAllCities()
        CoreDataService.shared.myFetchedResultController.delegate
         = self
       
        do {
           try CoreDataService.shared.myFetchedResultController.performFetch()
            tableView.reloadData()
        }catch {
            
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return  CoreDataService.shared.myFetchedResultController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = CoreDataService.shared.myFetchedResultController.sections?[section] else {
            return nil
        }
        return sectionInfo.name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return citiesFromDB.count
        
        guard let sections = CoreDataService.shared.myFetchedResultController.sections else {
               fatalError("No sections in fetchedResultsController")
           }
           let sectionInfo = sections[section]
           return sectionInfo.numberOfObjects
    }

    
    
    func searchDifFinishWithASelectedCity(city: City) {
     //   citiesFromDB.append(city)
        //citiesFromDB = CoreDataService.shared.getAllCities()
        
        do {
           try CoreDataService.shared.myFetchedResultController.performFetch()
            tableView.reloadData()
        }catch {
            
        }
        
    }
    
    func searchDidCancel() {
        print ("Cancel")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSearch"{
            let SVC = segue.destination as! SearchTableViewController
            SVC.delegate = self
            
        } else {
          
            let index = (tableView.indexPathForSelectedRow)!
            let WVC = segue.destination as! WeatherViewController
            
            let object = CoreDataService.shared.myFetchedResultController.object(at: index)
        
            WVC.selectedCity = City(city: (object as CityDB).name!, state:  (object as CityDB).provice!, country:  (object as CityDB).country!)
            
           
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

      let object = CoreDataService.shared.myFetchedResultController.object(at: indexPath)

        cell.textLabel?.text = (object as CityDB).name
        cell.detailTextLabel?.text = (object as CityDB).country

        return cell
        //cell.textLabel?.text = citiesFromDB[indexPath.row].name
        //cell.detailTextLabel?.text = citiesFromDB[indexPath.row].country

        return cell
    }
    
    
    
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = CoreDataService.shared.myFetchedResultController.object(at: indexPath)
        
        if editingStyle == .delete {
            CoreDataService.shared.deleteCity(cityToDelete: object as CityDB)
            
            do {
               try CoreDataService.shared.myFetchedResultController.performFetch()
                tableView.reloadData()
            }catch {
                
            }
            

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
