//
//  loadingController.swift
//  Explore
//
//  Created by Pradyumn Bangera on 6/7/20.
//  Copyright © 2020 Pradyumn Bangera. All rights reserved.
//

import UIKit

var hello: String = "bvejh"
class loadingController: UIViewController {
    
    @IBOutlet weak var usaOutlet: UIButton!
    @IBOutlet weak var alsOutlet: UIButton!
    @IBOutlet weak var selectOutlet: UILabel!
    


    @IBAction func usaAction(_ sender: Any) {
        currentState = "US"
        stateLabel = "United States"
        stateColor = .systemGreen
        self.performSegue(withIdentifier: "usa", sender: self)
    }
    
    
    func getData() {
        
        for s in states{
            stDeaths[s] = covidInfo(deaths: 0, cases: 0, caseIncrease: 0, deathIncrease: 0, hospitalized: 0, hospitalizedIncrease: 0, totalHospitalized: 0, totalTests: 0, negativeResults: 0, recovered: 0)
        }
        
        let resource: String = "https://covidtracking.com/api/v1/states/current.json"
        let resourceStateInfo: String = "https://covidtracking.com/api/states/info"
        guard let resURL = URL(string: resource) else {fatalError()}
        let session = URLSession.shared
        let dataTask = session.dataTask(with: resURL) { (data, respose, error) in
            
            if data != nil && error == nil{
                let decoder = JSONDecoder()
                do{
                    resp = try decoder.decode([Info].self, from: data!)
                    //print(resp)
                    var totalD:Int = 0
                    var totalC:Int = 0
                    var totalDIncrease: Int = 0
                    var totalCIncrease: Int = 0
                    var hosp: Int = 0
                    var HospIncrease: Int = 0
                    var neg: Int = 0
                    var recov: Int = 0
                    var tots: Int = 0
                    for i in resp{
                        totalD += i.death
                        totalC += i.positive
                        totalDIncrease += i.deathIncrease
                        totalCIncrease += i.positiveIncrease
                        tots += i.total
                        if i.hospitalizedCurrently != nil{
                            hosp += i.hospitalizedCurrently!
                        }
                        HospIncrease += i.hospitalizedIncrease
                        if i.negative != nil{
                            neg += i.negative!
                        }
                        stDeaths[i.state]?.caseIncrease = i.positiveIncrease
                        stDeaths[i.state]?.deathIncrease = i.deathIncrease
                        stDeaths[i.state]?.deaths = i.death
                        stDeaths[i.state]?.cases = i.positive
                        stDeaths[i.state]?.hospitalized = i.hospitalizedCurrently!
                        stDeaths[i.state]?.hospitalizedIncrease = i.hospitalizedIncrease
                        stDeaths[i.state]?.totalTests = i.total
                        stDeaths[i.state]?.negativeResults = i.negative!
                        if i.recovered != nil{
                            stDeaths[i.state]?.recovered = i.recovered!
                            recov += i.recovered!
                        }
                        else{
                            stDeaths[i.state]?.recovered = 0
                        }
                    }
                    stDeaths["US"]?.deaths = totalD
                    stDeaths["US"]?.cases = totalC
                    stDeaths["US"]?.caseIncrease = totalCIncrease
                    stDeaths["US"]?.deathIncrease = totalDIncrease
                    stDeaths["US"]?.recovered = recov
                    stDeaths["US"]?.hospitalized = hosp
                    stDeaths["US"]?.hospitalizedIncrease = HospIncrease
                    stDeaths["US"]?.negativeResults = neg
                    stDeaths["US"]?.totalTests = tots

                    
                    
                }catch{
                    print("Error while printing")
                }
            }
        }
        
        dataTask.resume()
        
        
    }
    
    @IBAction func getStarted(_ sender: Any) {
        self.performSegue(withIdentifier: "allStates", sender: self)
    }
    override func viewDidLoad() {
        
        usaOutlet.frame = CGRect(x: 47, y: 170, width: 320, height: 320)
        usaOutlet.layer.cornerRadius = 20
        usaOutlet.layer.masksToBounds = true
        usaOutlet.backgroundColor = .systemGray5
        
        alsOutlet.frame = CGRect(x: 47, y: 510, width: 320, height: 320)
        alsOutlet.layer.cornerRadius = 20
        alsOutlet.layer.masksToBounds = true
        alsOutlet.backgroundColor = .systemGray5
        
        selectOutlet.frame = CGRect(x: 47, y: 115, width: 200, height: 40)
        
        
        getData()

    }
    
    
}
