//
//  ViewController.swift
//  ex2
//
//  Created by Laura on 15/08/2018.
//  Copyright © 2018 Laura. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import Foundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate , MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var velloStations: UILabel!
    @IBOutlet weak var fixedLastUpdate: UILabel!
    @IBOutlet weak var lastUpdateCoreData: UILabel!
    @IBOutlet weak var stationsButton: UIButton!
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    var i = 0

    let tracker = CLLocationManager()
    var locations = [MKAnnotation]()
    var lastUpdated = Date()
    
    class Station: Decodable{
        var address = ""
        var available_bike_stands = 0
        var available_bikes = 0
        var banking = Bool(false)
        var bike_stands = 0
        var bonus = Bool(false)
        var contract_name = ""
        var name = ""
        var last_update = 0
      //  var lastUpdate: Date
        var number = 0
        var position: Position
        var status = ""
        
       // init(address: String, abs: Int, ab:Int, banking: Bool, bs: Int, bonus: Bool, cn: String, name: String, lu: Int,  number: Int, pos: Position, status: String)
        
        init()
        {
            self.address = ""
            self.available_bike_stands = 0
            self.available_bikes = 0
            self.banking = false
            self.bike_stands = 0
            self.bonus = false
            self.contract_name = ""
            self.name = ""
            self.last_update = 0
       //     self.lastUpdate = lup
            self.number = 0
            self.position = Position()
            self.status = ""
            
        }
    }
    struct Position: Decodable {
        var lat: Double
        var lng: Double
        
        init()
        {
            self.lat = 0
            self.lng = 0
        }
    }
    
    var fullInfo = [Station]()
    


    @IBAction func addMarksOnMapView(_ sender: Any) {
        stationsButton.isHidden = true
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let mark = MKPointAnnotation()
        print(fullInfo.count)
        for info in fullInfo
         {
            print(info.address)
         let myLat = Double(info.position.lat)
         let myLong = Double(info.position.lng)
         
         let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLong)
         let region: MKCoordinateRegion = MKCoordinateRegionMake( location, span)
         mapView.setRegion(region, animated: true)
         
          let mark = MKPointAnnotation()
         
         mark.coordinate = location
         mark.title = info.name
         
         locations.append(mark)
        // DispatchQueue.main.async {
         self.mapView.addAnnotation(mark)
     
        // }
        
    }
    }
    /*
    func addMarksOnMap()
    {
        //MAP CARD
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
      print("smth")
        let mark = MKPointAnnotation()
        for info in fullInfo
        {
            let myLat = Double(info.position.lat)
            let myLong = Double(info.position.lng)
            
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLong)
            let region: MKCoordinateRegion = MKCoordinateRegionMake( location, span)
            mapView.setRegion(region, animated: true)
            
          //  let mark = MKPointAnnotation()
          
            mark.coordinate = location
            mark.title = info.name
            
            locations.append(mark)
            DispatchQueue.main.async {
                self.mapView.addAnnotation(mark)
            }
 
    }
}
    */
  func addMarksOnMap()
    {
        //MAP CARD
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let mark = MKPointAnnotation()
        print(fullInfo.count)
        for info in fullInfo
        {
            print(info.address)
            let myLat = Double(info.position.lat)
            let myLong = Double(info.position.lng)
            
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLong)
            let region: MKCoordinateRegion = MKCoordinateRegionMake( location, span)
            mapView.setRegion(region, animated: true)
            
            let mark = MKPointAnnotation()
            
            mark.coordinate = location
            mark.title = info.name
            
            locations.append(mark)
            // DispatchQueue.main.async {
            self.mapView.addAnnotation(mark)
            
            // }
        }
    }
    
    
    func getDataForTheFirstTimeFromJSON(completion: @escaping (_ success: Bool) -> Void)
    {
        clearData() { (succes) -> Void in
            if succes{
                let context = (self.delegate)?.persistentContainer.viewContext //FOR CORE DATA
                
                let jsonUrl = "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale"
                
                guard let url = URL(string: jsonUrl) else
                {return}
                
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    
                    
                    guard let data = data else { return }
                    do {
                        
                        let station = try JSONDecoder().decode([Station].self, from: data)
                        
                        //      let myStation:[Station] = station
                        
                        
                        let coreDataHolder = NSEntityDescription.insertNewObject(forEntityName: "VilloEn", into: context!)
                        
                        for item in station
                        {
                            coreDataHolder.setValue( item.address, forKey:"address")
                            coreDataHolder.setValue( item.available_bikes, forKey:"available_bikes")
                            coreDataHolder.setValue( item.available_bike_stands, forKey:"available_bike_stands")
                            coreDataHolder.setValue( item.banking, forKey:"banking")
                            coreDataHolder.setValue( item.bike_stands, forKey:"bike_stands")
                            coreDataHolder.setValue( item.bonus, forKey:"bonus")
                            coreDataHolder.setValue( item.name, forKey:"name")
                            coreDataHolder.setValue( item.contract_name, forKey:"contract_name")
                            coreDataHolder.setValue( item.last_update, forKey:"last_update")
                            coreDataHolder.setValue( item.position.lat, forKey:"lat")
                            coreDataHolder.setValue( item.position.lng, forKey:"long")
                            coreDataHolder.setValue( item.number, forKey:"number")
                            coreDataHolder.setValue( item.status, forKey:"status")
                            coreDataHolder.setValue( Date(), forKey:"lastUpdated")
                            //print(coreDataHolder)
                          
                            do{
                                try(context?.save())
                                completion(true)
                            }
                            catch
                            {
                                print("error")
                            }
                        }
                        
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }
                    
                    
                    
                    }.resume()
            }
        
    }
}
    
    @IBAction func updateCoreDataAtUsersRequest(_ sender: Any) {
        clearData() { (succes) -> Void in
            if succes{
        
                let context = (self.delegate)?.persistentContainer.viewContext //FOR CORE DATA
        
        let jsonUrl = "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale"
        
        guard let url = URL(string: jsonUrl) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            
            guard let data = data else { return }
            do {
                
                let station = try JSONDecoder().decode([Station].self, from: data)
                
                //      let myStation:[Station] = station
                
                
                var coreDataHolder = NSEntityDescription.insertNewObject(forEntityName: "VilloEn", into: context!)
                
                for item in station
                {
                    coreDataHolder.setValue( item.address, forKey:"address")
                    coreDataHolder.setValue( item.available_bikes, forKey:"available_bikes")
                    coreDataHolder.setValue( item.available_bike_stands, forKey:"available_bike_stands")
                    coreDataHolder.setValue( item.banking, forKey:"banking")
                    coreDataHolder.setValue( item.bike_stands, forKey:"bike_stands")
                    coreDataHolder.setValue( item.bonus, forKey:"bonus")
                    coreDataHolder.setValue( item.name, forKey:"name")
                    coreDataHolder.setValue( item.contract_name, forKey:"contract_name")
                    coreDataHolder.setValue( item.last_update, forKey:"last_update")
                    coreDataHolder.setValue( item.position.lat, forKey:"lat")
                    coreDataHolder.setValue( item.position.lng, forKey:"long")
                    coreDataHolder.setValue( item.number, forKey:"number")
                    coreDataHolder.setValue( item.status, forKey:"status")
                    coreDataHolder.setValue( Date(), forKey:"lastUpdated")
                    //      coreDataHolder.name = item.name
                    //   print(coreDataHolder.name)
                    //     print(coreDataHolder)
                    
                    do{
                        try(context?.save())
                        
                        self.readCoreData{ (succes) -> Void in
                            if succes{
                                //MAP

                               // self.addMarksOnMap()                    }
                        }
                    }
                    }
                    catch
                    {
                        print("error")
                    }
                }
                
                
                //print(myStation[0].address)
                
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
            
            }.resume()
    }
            
        }
    }

    func clearData(completion: @escaping (_ success: Bool) -> Void) {
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VilloEn")
                    
                    let objects = try(context.fetch(fetchRequest)) as? [NSManagedObject]
                    
                    for object in objects! {
                        context.delete(object)
                    }
                
                
                try(context.save())
                completion(true)
                
                
            } catch let err {
                print(err)
            }
            
        }
    }
    
    func readCoreData(completion: @escaping (_ succes: Bool) -> Void) {
        
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                
                //let entityName = ["VilloEn"]
                
               
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VilloEn")
                    
                  //  let objects = try(context.executeFetchRequest(fetchRequest)) as? [NSManagedObject]
                
                fetchRequest.returnsObjectsAsFaults = false
                
                do{
                    let results = try context.fetch(fetchRequest)
                    
                    if results.count > 0
                    {
                        
                        for result in results as! [NSManagedObject]
                        {
                           // print(result)
                        //    fullInfo.append(result)
                            var info = Station()
                            info.address = result.value(forKey: "address") as! String
                            info.available_bike_stands = result.value(forKey: "available_bike_stands") as! Int
                            info.available_bikes = result.value(forKey: "available_bikes") as! Int
                            info.banking = result.value(forKey: "banking") as! Bool
                            info.bike_stands = result.value(forKey: "bike_stands") as! Int
                            info.bonus = result.value(forKey: "bonus") as! Bool
                            info.contract_name = result.value(forKey: "contract_name") as! String
                            info.last_update = result.value(forKey: "last_update") as! Int
                            info.position.lat = result.value(forKey: "lat") as! Double
                            info.position.lng = result.value(forKey: "long") as! Double
                            info.name = result.value(forKey: "name") as! String
                            info.number = result.value(forKey: "number") as! Int
                            info.status = result.value(forKey: "status") as! String
                            //info.lastUpdate = result.value(forKey: "lastUpdated") as! Date
                            lastUpdated = result.value(forKey: "lastUpdated") as! Date
                            fullInfo.append(info)
                        }
                    }
                    print(fullInfo.count)
                }
                completion(true)
                i = -1
            } catch let err {
                print(err)
            }
        }
    }
    
    @IBAction func goToEnglish(_ sender: Any) {
        
        if Bundle.main.preferredLocalizations.first != "en" {
            
            let confirmAlertCtrl = UIAlertController(title: NSLocalizedString("Fermer l'application pour appliquer les modifications", comment: ""), message: NSLocalizedString("Relancez manuellement", comment: ""), preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: NSLocalizedString("Fermer", comment: ""), style: .destructive)
            {_ in UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                exit(EXIT_SUCCESS)
            }
            
            confirmAlertCtrl.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Anuller", comment: ""), style: . cancel, handler: nil)
            
            confirmAlertCtrl.addAction(cancelAction)
            
            present(confirmAlertCtrl, animated: true, completion: nil)
            
            
        }

    }
    
    @IBAction func goToFrench(_ sender: Any) {
        
        if Bundle.main.preferredLocalizations.first != "fr" {
            
            let confirmAlertCtrl = UIAlertController(title: NSLocalizedString("Close the app to apply the changes", comment: ""), message: NSLocalizedString("Relaunch manually", comment: ""), preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .destructive)
            {_ in UserDefaults.standard.set(["fr"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                exit(EXIT_SUCCESS)
            }
            
            confirmAlertCtrl.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: . cancel, handler: nil)
            
            confirmAlertCtrl.addAction(cancelAction)
            
            present(confirmAlertCtrl, animated: true, completion: nil)
            
            
        }
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        getDataForTheFirstTimeFromJSON() { (success) -> Void in
            if success {
                // do second task if success
                self.readCoreData() { (succes) -> Void in
                    if succes{
                        //MAP
                     //   print(self.fullInfo[0].position.lat)
                        
                        self.tracker.delegate = self as? CLLocationManagerDelegate
                        self.tracker.desiredAccuracy = kCLLocationAccuracyBest

                    //    self.addMarksOnMap(lat: self.fullInfo[self.fullInfo.count-1].position.lat,long: //self.fullInfo[self.fullInfo.count-1].position.lng)
                    //    self.addMarksOnMap()
                        //    self.tracker.requestWhenInUseAuthorization()
                        //  self.tracker.startUpdatingLocation()
                        
                        // let devicelatitude = (self.tracker.location?.coordinate.latitude)!
                        //  let devicelongitude = (self.tracker.location?.coordinate.longitude)!
                        //      print(devicelatitude)
                        //   print(devicelongitude)
                        
                      //  self.addMarksOnMap() { (succes) -> Void in
                      //      if succes{
                              /*  let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
                                let mark = MKPointAnnotation()
                                let myLat = Double(self.fullInfo[0].position.lat)
                                let myLong = Double(self.fullInfo[0].position.lng)
                                let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLong)
                                let region: MKCoordinateRegion = MKCoordinateRegionMake( location, span)
                                self.mapView.setRegion(region, animated: true)
                                
                                
                                mark.coordinate = location
                                mark.title = self.fullInfo[0].name
                                
                                self.locations.append(mark)
                                DispatchQueue.main.async {
                              self.mapView.addAnnotation(mark)
                                }
                            print("OMG")*/
                        
                   // }
              //  }
            }
        }
    }
}
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

