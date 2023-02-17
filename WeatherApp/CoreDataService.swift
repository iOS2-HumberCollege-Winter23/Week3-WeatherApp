//
//  CoreDataService.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-02-10.
//

import Foundation

import CoreData

class CoreDataService {
    
    static var shared = CoreDataService()
    
    
   lazy var myFetchedResultController : NSFetchedResultsController<CityDB> = {
        
      var fetch =  CityDB.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor.init(key: "country", ascending: true)]
        
        
       let fetchController = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: "country", cacheName: nil)
        
        return fetchController
        
    }()
    
    
    func insertNewCityToDB(city: City){
     // check if the city is not in the database
        //select * from CityDB where name == name and country == country
       
        let fetchRequest = CityDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name MATCHES [c] %@ AND country MATCHES [c] %@", city.cityName as CVarArg , city.countryName as CVarArg)
        
        do {
        var listOfSimilarCities =  try persistentContainer.viewContext.fetch(fetchRequest)
            if listOfSimilarCities.count > 0 {
                
                
            }else {
                let newCity = CityDB(context: persistentContainer.viewContext)
                newCity.name = city.cityName
                newCity.country = city.countryName
                newCity.provice = city.stateName
                
                saveContext()
            }
        }
        catch{}
        
        
        
    }
    
    func updateCity(toUpdateCity: CityDB){
        toUpdateCity.name = "new name"
        toUpdateCity.country = "new country"
        
        saveContext()
        
    }
    
    func getAllCities() -> [CityDB]{
        // select * from CityDB
        // order By
        
        var cities = [CityDB]()
        let fetchRequest = CityDB.fetchRequest()
       
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true), NSSortDescriptor.init(key: "country", ascending: false)]
       
        do{
            cities = try persistentContainer.viewContext.fetch(fetchRequest)
          
        }catch {
            
            
        }
        
        return cities
        
        
    }
    
    func deleteCity(cityToDelete: CityDB){
       
        persistentContainer.viewContext.delete(cityToDelete)
        saveContext()
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
         
            let container = NSPersistentContainer(name: "citiesDB")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                   
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        // MARK: - Core Data Saving support
        
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

}
