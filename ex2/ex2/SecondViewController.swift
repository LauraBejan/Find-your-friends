//
//  SecondViewController.swift
//  ex2
//
//  Created by Laura on 15/08/2018.
//  Copyright © 2018 Laura. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var coordinates: UILabel!
    @IBOutlet weak var banking: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var contract: UILabel!
    @IBOutlet weak var bikeStands: UILabel!
    @IBOutlet weak var availableBikeStands: UILabel!
    @IBOutlet weak var availableBikes: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    
    
    @IBOutlet weak var fixedAddress: UILabel!
    @IBOutlet weak var fixedNumber: UILabel!
    @IBOutlet weak var fixedCoordinates: UILabel!
    @IBOutlet weak var fixedBanking: UILabel!
    @IBOutlet weak var fixedBonus: UILabel!
    @IBOutlet weak var fixedStatus: UILabel!
    @IBOutlet weak var fixedContract: UILabel!
    @IBOutlet weak var fixedBikeStands: UILabel!
    @IBOutlet weak var fixedAvailableBikeStands: UILabel!
    @IBOutlet weak var fixedAvailableBikes: UILabel!
    @IBOutlet weak var fixedLastUpdate: UILabel!
    
    var passedName = ""
    var passedAddress = ""
    var passedNumber = 0
    var passedBanking = true
    var passedABS = 0
    var passedAB = 0
    var passedBS = 0
    var passedBonus = true
    var passedCN = ""
    var passedLU = 0
    var passedStatus = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = passedName
        address.text = passedAddress
        number.text = String(passedNumber)
        banking.text = String(passedBanking)
        availableBikeStands.text = String(passedABS)
        bikeStands.text = String(passedBS)
        availableBikes.text = String(passedAB)
        bonus.text = String(passedBonus)
        contract.text = passedCN
        lastUpdate.text = String(passedLU)
        status.text = String(passedStatus)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
