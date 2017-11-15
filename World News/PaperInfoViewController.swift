//
//  PaperInfoViewController.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/2/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class PaperInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableview: UITableView!
    
    var getname = String()
    var sources: [Source]? = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaperTableViewCell", for: indexPath) as! PaperTableViewCell
        cell.title.text = self.sources?[indexPath.item].name
        cell.desc.text = self.sources?[indexPath.item].desc
        cell.url.text = self.sources?[indexPath.item].url
        return cell
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = getname
        var country = ""
        
        if getname == "india" {
            country = "in"
        }else if getname == "united-states" {
            country = "us"
        }else if getname == "united-kingdom" {
            country = "gb"
        }else if getname == "australia" {
            country = "au"
        }else if getname == "germany" {
            country = "de"
        }else if getname == "italy" {
            country = "it"
        }
        let jsonURL = "https://newsapi.org/v1/sources?country=\(country)&key=f82b74f968a840d29cc8d70077d6951b"
        
        print("url:", jsonURL)
        print("country:", country)
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
                            if let name = sourcesFromJson["name"] as? String, let desc = sourcesFromJson["description"] as? String, let url = sourcesFromJson["url"] as? String{
                                
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
                    }
                    // Set the spacing between sections
                    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                        return 20
                    }
                    
                }catch  let jsonErr{
                    print("Erro serializing json:", jsonErr)}
            }; task.resume()
            
        }
        
        
    }

