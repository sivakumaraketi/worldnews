//
//  ViewController.swift
//  World News
//
//  Created by Siva Kumar Aketi on 10/30/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var name:NSArray = []
    var imageArr:NSArray = []
    var countrycode:NSArray = []
    
    // Set the spacing between sections
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
       
        
        cell.imgImage.image = (imageArr[indexPath.row] as! UIImage)
        cell.lblName.text! = name[indexPath.row] as! String
        cell.layer.cornerRadius=10
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        name = ["india","united-states","united-kingdom","australia","germany","italy"]
        countrycode = ["in","us","ac","de","it"]
        imageArr = [UIImage(named: "india")!,UIImage(named: "united-states")!,UIImage(named: "united-kingdom")!,UIImage(named: "australia")!,UIImage(named: "germany")!,UIImage(named: "italy")!]
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

