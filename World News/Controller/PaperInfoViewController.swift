//
//  PaperInfoViewController.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/2/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class PaperInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableview: UITableView!
    
    var rechability:Reachability?
    
    var getname = String()
    var getcountrycode = String()
    var sources: [Source]? = []
    var articleUrl = String()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaperTableViewCell", for: indexPath) as! PaperTableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius=10
        
        cell.title.text = self.sources?[indexPath.item].name
        cell.desc.text = self.sources?[indexPath.item].desc
      //  cell.url.text = self.sources?[indexPath.item].url
        articleUrl = (self.sources?[indexPath.item].url)!
        cell.url.text = articleUrl
        cell.url.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self,action: #selector(PaperInfoViewController.tapUrl))
        cell.url.addGestureRecognizer(tap)
        return cell
    }
    
    @objc func tapUrl(){
        print("tapped")
        let Storyboard = UIStoryboard(name: "Main",bundle:nil)
        let DVC = Storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        DVC.url = articleUrl
        self.navigationController?.pushViewController(DVC, animated: true)
        
    }
    
    // Set the spacing between sections
  /*  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //tableView.backgroundColor = UIColor.white
        return 20
    }*/
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 220
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rechability = Reachability.init()
        
        if ((self.rechability!.connection) != .none){
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = getname
       self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        var country = ""
        
        if getname == "India" {
            country = "in"
        }else if getname == "United States" {
            country = "us"
        }else if getname == "United Kingdom" {
            country = "gb"
        }else if getname == "Australia" {
            country = "au"
        }else if getname == "Germany" {
            country = "de"
        }else if getname == "Italy" {
            country = "it"
        }
        let jsonURL = commonurl + "sources?country=\(country)&" + apiKey
        
        print("url:", jsonURL)
       // print("country:", country)
            guard let url = URL(string: jsonURL) else{
                return}
            
            let task = URLSession.shared.dataTask(with: url){(data, _, _) in
                guard let data = data else{return}
                
                self.sources = [Source]()
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else{return}
                    
                    if let sourcesFromJson = json["sources"] as?[[String : AnyObject]]{
                        
                        for sourcesFromJson in sourcesFromJson{
                            let source = Source()
                            if let id = sourcesFromJson["id"] as? String,let name = sourcesFromJson["name"] as? String, let desc = sourcesFromJson["description"] as? String, let url = sourcesFromJson["url"] as? String{
                                
                                source.id = id
                                source.name = name
                                source.desc = desc
                                source.url = url
                                /* print("name:", name)
                                 print("description:", description)
                                 print("url:", url)*/
                                
                                
                            }
                            self.sources?.append(source)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                        self.activity.stopAnimating()
                    }
                   
                    
                }catch  let jsonErr{
                    print("Erro serializing json:", jsonErr)}
            }; task.resume()
           
        }else {
          
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "PaperInfoDetailViewController") as! PaperInfoDetailViewController
        Dvc.getname = (self.sources?[indexPath.item].name)!
        Dvc.getid = (self.sources?[indexPath.item].id)!
        
        
        self.navigationController?.pushViewController(Dvc, animated: true)
        
        
    }
    
        
    
    }

