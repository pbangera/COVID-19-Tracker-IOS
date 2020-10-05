//
//  stateDetailsControlllerViewController.swift
//  Explore
//
//  Created by Pradyumn Bangera on 6/6/20.
//  Copyright © 2020 Pradyumn Bangera. All rights reserved.
//

import UIKit
import CoreImage

var info = stDeaths

var respMI:[mi] = []
class stateDetailsController: UIViewController {
    
    @IBOutlet weak var stateButtonOutlet: UIButton!
    
    @IBOutlet weak var stateNameOutlet: UILabel!
    
    @IBOutlet weak var moreInfoOutlet: UIButton!
    
    @IBOutlet weak var stateDetailsViewOutlet: UIView!
    
    @IBAction func moreInfoAction(_ sender: Any) {
        let myUrl = info[currentState]!.covid19SiteOld ?? ""
           if let url = URL(string: myUrl), !url.absoluteString.isEmpty {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
    }
    
    func getData() {
        


        let resource: String = "https://covidtracking.com/api/states/info"
        guard let resURL = URL(string: resource) else {fatalError()}
        let session = URLSession.shared
        let dataTask = session.dataTask(with: resURL) { (data, respose, error) in
            
            if data != nil && error == nil{
                let decoder = JSONDecoder()
                do{
                    respMI = try decoder.decode([mi].self, from: data!)
                    //print(resp)
                    for i in respMI{
                        info[i.state!]?.covid19SiteOld = i.covid19SiteOld
                    }


                    
                    
                }catch{
                    print("Error while printing")
                }
            }
        }
        
        dataTask.resume()
        
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        //UIApplication.shared.open("www.google.com", options: [], completionHandler: nil)

    }

    
    override func viewDidLoad() {
          self.getData()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
//        var scrollView: UIScrollView!
        
        let deathLabel = UILabel(frame: CGRect(x: 10, y: 165, width: 192, height: 200))
        deathLabel.backgroundColor = .systemGray5
        deathLabel.layer.cornerRadius = 20
        deathLabel.layer.masksToBounds = true
        deathLabel.layer.borderColor = UIColor.systemGreen.cgColor
        deathLabel.layer.borderWidth = 0
        deathLabel.textAlignment = .center
        deathLabel.numberOfLines = 0
        deathLabel.font = deathLabel.font.withSize(32)
        deathLabel.backgroundColor = .systemGray5
        
        
        func formatNums(num: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:num))
            return formattedNumber!
        }
        

       
        
        //scrollView = UIScrollView(frame: self.view.bounds)
        deathLabel.text = "Deaths 💔\n\n\(formatNums(num:info[currentState]!.deaths))\n🔺\(formatNums(num:info[currentState]!.deathIncrease))"
        self.view.addSubview(deathLabel)

        
        
        let caseLabel = UILabel(frame: CGRect(x: 212, y: 165, width: 192, height: 200))
        caseLabel.backgroundColor = .systemGray5
        caseLabel.layer.cornerRadius = 20
        caseLabel.layer.masksToBounds = true
        caseLabel.textAlignment = .center
        caseLabel.font = caseLabel.font.withSize(32)
        caseLabel.numberOfLines = 0
        caseLabel.text = "Cases 🦠\n\n\(formatNums(num:info[currentState]!.cases))\n🔺\(formatNums(num:info[currentState]!.caseIncrease))"
        caseLabel.backgroundColor = .systemGray5
        self.view.addSubview(caseLabel)
        
        let infLabel = UILabel(frame: CGRect(x: 10, y: 375, width: 192, height: 200))
        infLabel.backgroundColor = .systemGray5
        infLabel.layer.cornerRadius = 20
        infLabel.layer.masksToBounds = true
        infLabel.textAlignment = .center
        infLabel.font = infLabel.font.withSize(32)
        infLabel.numberOfLines = 0
        infLabel.backgroundColor = .systemGray5
        infLabel.text = "Total Tests 🤒\n\n\(formatNums(num:info[currentState]!.totalTests))"
        self.view.addSubview(infLabel)
        
        let posLabel = UILabel(frame: CGRect(x: 212, y: 375, width: 192, height: 95))
        posLabel.backgroundColor = .systemGray5
        posLabel.layer.cornerRadius = 20
        posLabel.layer.masksToBounds = true
        posLabel.textAlignment = .center
        posLabel.font = infLabel.font.withSize(26)
        posLabel.numberOfLines = 0
        posLabel.backgroundColor = .systemGray5
        posLabel.text = "Pos. Tests 🔴\n\(formatNums(num:info[currentState]!.cases))"
        self.view.addSubview(posLabel)
        
        let negLabel = UILabel(frame: CGRect(x: 212, y: 480, width: 192, height: 95))
        negLabel.backgroundColor = .systemGray5
        negLabel.layer.cornerRadius = 20
        negLabel.layer.masksToBounds = true
        negLabel.textAlignment = .center
        negLabel.font = infLabel.font.withSize(26)
        negLabel.numberOfLines = 0
        negLabel.backgroundColor = .systemGray5
        negLabel.text = "Neg. Tests 🟢\n\(formatNums(num:info[currentState]!.totalTests - info[currentState]!.cases))"
        self.view.addSubview(negLabel)
        
        
        
        moreInfoOutlet.backgroundColor = .systemGray5
        moreInfoOutlet.layer.cornerRadius = 20
        moreInfoOutlet.layer.masksToBounds = true
        moreInfoOutlet.titleLabel?.textAlignment = .center
        moreInfoOutlet.titleLabel?.font.withSize(22)
        moreInfoOutlet.titleLabel?.numberOfLines = 0
        moreInfoOutlet.backgroundColor = .systemGray5
       // moreInfoOutlet.setTitle("ℹ", for: .normal)
        moreInfoOutlet.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        moreInfoOutlet.frame = CGRect(x: 334, y: 795, width: 70, height: 70)
        
        
        
        
        let hosLabel = UILabel(frame: CGRect(x: 10, y: 585, width: 192, height: 200))
        hosLabel.backgroundColor = .systemGray5
        hosLabel.layer.cornerRadius = 20
        hosLabel.layer.masksToBounds = true
        hosLabel.textAlignment = .center
        hosLabel.font = infLabel.font.withSize(26)
        hosLabel.numberOfLines = 0
        hosLabel.backgroundColor = .systemGray5
        if info[currentState]!.hospitalizedIncrease > 0{
            hosLabel.text = "Hospitalized 🚑\n\n\(formatNums(num:info[currentState]!.hospitalized))\n🔺\(formatNums(num:info[currentState]!.hospitalizedIncrease))"
        }
        else if info[currentState]!.hospitalizedIncrease < 0{
             hosLabel.text = "Hospitalized 🚑\n\n\(formatNums(num:info[currentState]!.hospitalized))\n🔻\(formatNums(num:info[currentState]!.hospitalizedIncrease))"
        }
        else{
            hosLabel.text = "Hospitalized 🚑\n\n\(formatNums(num:info[currentState]!.hospitalized))\n⚪️\(formatNums(num:info[currentState]!.hospitalizedIncrease))"
        }
        self.view.addSubview(hosLabel)
        
        let recLabel = UILabel(frame: CGRect(x: 212, y: 585, width: 192, height: 200))
        recLabel.backgroundColor = .systemGray5
        recLabel.layer.cornerRadius = 20
        recLabel.layer.masksToBounds = true
        recLabel.textAlignment = .center
        recLabel.font = infLabel.font.withSize(26)
        recLabel.numberOfLines = 0
        recLabel.backgroundColor = .systemGray5
        recLabel.text = "Recovered 👍🏼\n\n\(formatNums(num:info[currentState]!.recovered))\n"
        self.view.addSubview(recLabel)
        
        stateButtonOutlet.frame = CGRect(x: 330, y: 100, width: 55, height: 55)
        stateButtonOutlet.setTitleColor(stateColor, for: .normal) 
        stateButtonOutlet.layer.cornerRadius = stateButtonOutlet.bounds.size.width/2
        stateButtonOutlet.clipsToBounds = true
        stateButtonOutlet.layer.borderWidth = 1
        stateButtonOutlet.layer.borderColor = stateColor.cgColor
        stateButtonOutlet.setTitle(currentState, for: .normal)
        
        stateNameOutlet.text = stateLabel
        stateNameOutlet.textColor = stateColor
        stateNameOutlet.frame = CGRect(x: 10, y: 100, width: 300, height: 50)
        
        
        
        //scrollView.contentSize = self.view.bounds.size
        //self.view.addSubview(scrollView)
        super.viewDidLoad()

    }
    

    
}
