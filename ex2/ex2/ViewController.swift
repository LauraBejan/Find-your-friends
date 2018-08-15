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

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var velloStations: UILabel!
    @IBOutlet weak var fixedLastUpdate: UILabel!
    @IBOutlet weak var lastUpdateCoreData: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

