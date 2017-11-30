//
//  PaperInfoDetailViewController.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/16/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class PaperInfoDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var rechability:Reachability?
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return self.articles?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 370
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaperDetailTableViewCell", for: indexPath) as! PaperDetailTableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius=10
        
        cell.author.text = self.articles?[indexPath.item].author ?? ""
        cell.title.text = self.articles?[indexPath.item].title ?? ""
        cell.desc.text = self.articles?[indexPath.item].desc
        //cell.url.text = self.articles?[indexPath.item].url
        
        let urlimage = self.articles?[indexPath.item].urlimage
        if urlimage != nil{
          //  let data = NSData(contentsOf: (urlimage as? URL)!)
           // cell.imageView?.image = UIImage(data: data! as Data)
        cell.urlimage.downloadImage(from: (self.articles?[indexPath.item].urlimage)!)
        }
        //cell.urlimage.downloadImage(from: (self.articles?[indexPath.item].urlimage)!)
        return cell
    }

    
    @IBOutlet weak var tableview: UITableView!
    
    var getname = String()
    var getid = String()
    var articles: [Article]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.rechability = Reachability.init()
        
        if ((self.rechability!.connection) != .none){
        // Do any additional setup after loading the view.
        
       // print("url:", getid)
        
         self.navigationItem.title = getname
        
        let jsonURL = "https://newsapi.org/v1/articles?source=\(getid)&apikey=f82b74f968a840d29cc8d70077d6951b"
        
      //  print("url:", jsonURL)
      
        guard let url = URL(string: jsonURL) else{
            return}
        
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            guard let data = data else{return}
            
            self.articles = [Article]()
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else{return}
                
                if let articlesFromJson = json["articles"] as?[[String : AnyObject]]{
                    
                    for articlesFromJson in articlesFromJson{
                        let article = Article()
                        if let author = articlesFromJson["author"] as? AnyObject,let title = articlesFromJson["title"] as? String, let desc = articlesFromJson["description"] as? String, let url = articlesFromJson["url"] as? String, let urlimage = articlesFromJson["urlToImage"] as? String{
                            
                            if article.author != "<null>"{
                                article.author = author as? String
                            }
                            article.title = title
                            article.desc = desc
                            article.url = url
                            article.urlimage = urlimage
                            
                           
                            /* print("name:", name)
                             print("description:", description)
                             print("url:", url)*/
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.activity.stopAnimating()
                }
                // Set the spacing between sections
                func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                    return 20
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
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
       Dvc.url = self.articles?[indexPath.item].url
        
        
        self.navigationController?.pushViewController(Dvc, animated: true)
        
        
    }
    }


extension UIImageView {
    
    func downloadImage(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        if urlRequest != nil{
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            print("image loaded")
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
       
        task.resume()
         }
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


