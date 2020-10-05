//
//  ViewController.swift
//  Explore
//
//  Created by Pradyumn Bangera on 6/3/20.
//  Copyright © 2020 Pradyumn Bangera. All rights reserved.
//

import UIKit

struct covidInfo{
    var deaths: Int
    var cases: Int
    var caseIncrease: Int
    var deathIncrease: Int
    var hospitalized: Int
    var hospitalizedIncrease: Int
    var totalHospitalized: Int
    var totalTests: Int
    var covid19SiteOld: String?
    var negativeResults: Int
    var recovered: Int
    
}

var currentState: String = ""
var stateLabel: String = ""
var stateColor: UIColor = .clear
var resp:[Info] = []
var states:[String] = ["DC", "US", "MD", "NY", "TX", "CA", "MI", "VA"]
var stDeaths: [String: covidInfo] = [:]

class ViewController: UIViewController {
    
    
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    @IBOutlet weak var viewOutlet: UIView!
    
    
    //STATE BUTTON OUTLETS
    
    @IBOutlet weak var dcOutlet: UIButton!
    
    @IBOutlet weak var mdOutlet: UIButton!
    
    @IBOutlet weak var nyOutlet: UIButton!
    
    @IBOutlet weak var txOutlet: UIButton!
    
    @IBOutlet weak var caOutlet: UIButton!
    
    @IBOutlet weak var miOutlet: UIButton!
    
    @IBOutlet weak var vaOutlet: UIButton!
    
    //OUTLETS FOR CASES OF STATES
    
    @IBOutlet weak var dcCasesOutlet: UILabel!
    
    @IBOutlet weak var mdCasesOutlet: UILabel!
    
    @IBOutlet weak var nyCasesOutlet: UILabel!
    
    @IBOutlet weak var texasCasesOutlet: UILabel!
    
    @IBOutlet weak var caCasesOutlet: UILabel!
    
    @IBOutlet weak var miCasesOutlet: UILabel!
    
    @IBOutlet weak var viCasesOutlet: UILabel!
    
    
    //OUTLETS FOR DEATHS IN STATES
    
    @IBOutlet weak var dcDeathsOutlet: UILabel!
    
    @IBOutlet weak var mdDeathsOutlet: UILabel!
    
    @IBOutlet weak var nyDeathsOutlet: UILabel!
    
    @IBOutlet weak var texasDeathsOutlet: UILabel!
    
    @IBOutlet weak var caDeathsOutlet: UILabel!
    
    @IBOutlet weak var miDeathsOutlet: UILabel!
    
    @IBOutlet weak var vaDeathsOutlet: UILabel!
    
    
    //STATE BUTTON ACTIONS
    
    @IBAction func dcbuttonAction(_ sender: Any) {
        currentState = "DC"
        stateLabel = "Washington DC"
        stateColor = .systemYellow
        performSegue(withIdentifier: "md", sender: self)
    }
    
    @IBAction func mdbuttonAction(_ sender: Any) {
        currentState = "MD"
        stateLabel = "Maryland"
        stateColor = mdOutlet.titleColor(for: .normal)!
        performSegue(withIdentifier: "md", sender: self)
    }
    
    @IBAction func nybuttonAction(_ sender: Any) {
        currentState = "NY"
        stateLabel = "New York"
        stateColor = nyOutlet.titleColor(for: .normal)!
        performSegue(withIdentifier: "md", sender: self)
    }
    
    @IBAction func texasbuttonAction(_ sender: Any) {
        currentState = "TX"
        stateLabel = "Texas"
        stateColor = txOutlet.titleColor(for: .normal)!
        performSegue(withIdentifier: "md", sender: self)
    }
    
    @IBAction func cabuttonAction(_ sender: Any) {
        currentState = "CA"
        stateLabel = "California"
        stateColor = caOutlet.titleColor(for: .normal)!
        performSegue(withIdentifier: "md", sender: self)
    }
    
    @IBAction func mibuttonAction(_ sender: Any) {
        currentState = "MI"
        stateLabel = "Michigan"
        stateColor = miOutlet.titleColor(for: .normal)!
        performSegue(withIdentifier: "md", sender: self)
    }
    
    @IBAction func vabuttonAction(_ sender: Any) {
        currentState = "VA"
        stateLabel = "Virginia"
        stateColor = vaOutlet.titleColor(for: .normal)!
        performSegue(withIdentifier: "md", sender: self)
    }
    
    func formatNums(num: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:num))
        return formattedNumber!
    }
    
    
    func updateStats(){
        
        self.dcDeathsOutlet.text = "  Deaths: \(formatNums(num:stDeaths["DC"]!.deaths))"
        self.mdDeathsOutlet.text = "Deaths: \(formatNums(num:stDeaths["MD"]!.deaths))"
        self.nyDeathsOutlet.text = "Deaths: \(formatNums(num:stDeaths["NY"]!.deaths))"
        self.texasDeathsOutlet.text = "Deaths: \(formatNums(num:stDeaths["TX"]!.deaths))"
        self.caDeathsOutlet.text = "Deaths: \(formatNums(num:stDeaths["CA"]!.deaths))"
        self.miDeathsOutlet.text = "Deaths: \(formatNums(num:stDeaths["MI"]!.deaths))"
        self.vaDeathsOutlet.text = "Deaths: \(formatNums(num:stDeaths["VA"]!.deaths))"
        self.mdDeathsOutlet.textColor = .white
        
        self.dcCasesOutlet.text = "  Cases: \(formatNums(num:stDeaths["DC"]!.cases))"
        self.mdCasesOutlet.text = "Cases: \(formatNums(num:stDeaths["MD"]!.cases))"
        self.nyCasesOutlet.text = "Cases: \(formatNums(num:stDeaths["NY"]!.cases))"
        self.texasCasesOutlet.text = "Cases: \(formatNums(num:stDeaths["TX"]!.cases))"
        self.caCasesOutlet.text = "Cases: \(formatNums(num:stDeaths["CA"]!.cases))"
        self.miCasesOutlet.text = "Cases: \(formatNums(num:stDeaths["MI"]!.cases))"
        self.viCasesOutlet.text = "Cases: \(formatNums(num:stDeaths["VA"]!.cases))"
        self.mdCasesOutlet.textColor = .white
    }
    
    
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.view.backgroundColor = .blue
        dcOutlet.layer.cornerRadius = 20
        dcOutlet.layer.masksToBounds = true
        mdOutlet.layer.cornerRadius = 20
        mdOutlet.layer.masksToBounds = true
        nyOutlet.layer.cornerRadius = 20
        nyOutlet.layer.masksToBounds = true
        txOutlet.layer.cornerRadius = 20
        txOutlet.layer.masksToBounds = true
        caOutlet.layer.cornerRadius = 20
        caOutlet.layer.masksToBounds = true
        miOutlet.layer.cornerRadius = 20
        miOutlet.layer.masksToBounds = true
        vaOutlet.layer.cornerRadius = 20
        vaOutlet.layer.masksToBounds = true
        
        dcCasesOutlet.frame = CGRect(x: 258, y: 134, width: 141, height: 47)
        dcCasesOutlet.layer.cornerRadius = 15
        dcCasesOutlet.layer.masksToBounds = true
        //dcCasesOutlet.backgroundColor = .black
        dcDeathsOutlet.frame = CGRect(x: 258, y: 182, width: 141, height: 47)
        dcDeathsOutlet.layer.cornerRadius = 15
        dcDeathsOutlet.layer.masksToBounds = true
        //dcDeathsOutlet.backgroundColor = .black
        
        mdCasesOutlet.layer.cornerRadius = 20
        mdCasesOutlet.layer.masksToBounds = true
        mdDeathsOutlet.layer.cornerRadius = 20
        mdDeathsOutlet.layer.masksToBounds = true
        
        nyCasesOutlet.layer.cornerRadius = 20
        nyCasesOutlet.layer.masksToBounds = true
        nyDeathsOutlet.layer.cornerRadius = 20
        nyDeathsOutlet.layer.masksToBounds = true
        
        caCasesOutlet.layer.cornerRadius = 20
        caCasesOutlet.layer.masksToBounds = true
        caDeathsOutlet.layer.cornerRadius = 20
        caDeathsOutlet.layer.masksToBounds = true
        
        texasCasesOutlet.layer.cornerRadius = 20
        texasCasesOutlet.layer.masksToBounds = true
        texasDeathsOutlet.layer.cornerRadius = 20
        texasDeathsOutlet.layer.masksToBounds = true
        
        miCasesOutlet.layer.cornerRadius = 20
        miCasesOutlet.layer.masksToBounds = true
        miDeathsOutlet.layer.cornerRadius = 20
        miDeathsOutlet.layer.masksToBounds = true
        
        viCasesOutlet.layer.cornerRadius = 20
        viCasesOutlet.layer.masksToBounds = true
        vaDeathsOutlet.layer.cornerRadius = 20
        vaDeathsOutlet.layer.masksToBounds = true
        
        updateStats()
        super.viewDidLoad()
    }
    

    // Do any additional setup after loading the view.
    
}




