//
//  ViewController.swift
//  World News
//
//  Created by Siva Kumar Aketi on 10/30/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var rechability:Reachability?
    
    var name:NSArray = []
    var imageArr:NSArray = []
    var countrycode:NSArray = []
    //var countrysArray = [Country]()
    
    // Set the spacing between sections
    
   /* func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.backgroundColor = UIColor.green
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        
        return 20;
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return name.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius=10
    
    
        cell.imgImage.image = (imageArr[indexPath.row] as! UIImage)
        cell.lblName.text! = name[indexPath.row] as! String
        cell.lblName.textColor = txtcolor
        cell.lblName.highlightedTextColor = txtcolor
        
        
        
        
        return cell
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    
        return 100
    }
    
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.rechability = Reachability.init()
        
        
        if ((self.rechability!.connection) != .none){
        // Do any additional setup after loading the view.
            //Load Cars from plist into Array
        /*    let path = Bundle.main.path(forResource: "Country", ofType: "plist")
            let dictArray = NSArray(contentsOfFile: path!)
            
            for countryItem in dictArray! {
                let newCountry : Country = Country(type:(countryItem.objectForKey("name")) as! String, maker: (countryItem.objectForKey("countrycode")) as! String, model: (countryItem.objectForKey("imagename")) as! String, image:
                countrysArray.append(newCountry)
            }*/
        
        name = ["India","United States","United Kingdom","Australia","Germany","Italy"]
       countrycode = ["in","us","ac","de","it"]
        imageArr = [UIImage(named: "india")!,UIImage(named: "united-states")!,UIImage(named: "united-kingdom")!,UIImage(named: "australia")!,UIImage(named: "germany")!,UIImage(named: "italy")!]
        }else {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "PaperInfoViewController") as! PaperInfoViewController
        Dvc.getname = name[indexPath.row] as! String
       
        
        
        self.navigationController?.pushViewController(Dvc, animated: true)
        
        
    }
    
}

