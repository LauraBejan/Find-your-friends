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

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var velloStations: UILabel!
    @IBOutlet weak var fixedLastUpdate: UILabel!
    @IBOutlet weak var lastUpdateCoreData: UILabel!
    
    struct Station: Decodable{
        let address: String
        let available_bike_stands: Int
        let available_bikes: Int
        let banking: Bool
        let bike_stands: Int
        let bonus: Bool
        let contract_name: String
        let last_update: Int
        let name: String
        let number: Int
        let position: Position
        let status: String
    }
    struct Position: Decodable {
        let lat: Double
        let lng: Double
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func updatecoreData(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //FOR CORE DATA
        
        let jsonUrl = "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale"
        
            guard let url = URL(string: jsonUrl) else
            {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in

            
            guard let data = data else { return }
            do {
         
                let station = try JSONDecoder().decode([Station].self, from: data)

                let myStation:[Station] = station
                print(myStation[0].address)
          
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
            
            }.resume()
        
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
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

