//
//  PaperInfoDetailViewController.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/16/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class PaperInfoDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var rechability:Reachability?
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 370
    }
    var urlvalue = String()
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaperDetailTableViewCell", for: indexPath) as! PaperDetailTableViewCell
        
        
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius=10
        
        cell.author.text = self.articles[indexPath.item].author ?? "NA"
        cell.title.text = self.articles[indexPath.item].title ?? "No Title"
        cell.desc.text = self.articles[indexPath.item].desc ?? "No Desc"
        
        //cell.morelink.addTarget(self, action: #selector(PaperDetailTableViewCell.morelink(_:)), for: .touchUpInside)
        
        let urlvalue = self.articles[indexPath.item].url
        //print("urlvalueshowing:", urlvalue)
        cell.onButtonTapped = {
            print("more link tapped")
            let Storyboard = UIStoryboard(name: "Main",bundle:nil)
            let DVC = Storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
            DVC.url = urlvalue
            self.navigationController?.pushViewController(DVC, animated: true)
        }
        
        cell.onShareTapped = {
            let activityVC = UIActivityViewController(activityItems: [urlvalue], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
        
        
      print("urlvalue1:", urlvalue)
        
        
       // cell.url.text = self.articles[indexPath.item].url
        
        let urlimage = self.articles[indexPath.item].urlimage
        if urlimage != nil{
          //  let data = NSData(contentsOf: (urlimage as? URL)!)
           // cell.imageView?.image = UIImage(data: data! as Data)
        cell.urlimage.downloadImage(from: (self.articles[indexPath.item].urlimage)!)
        }
        //cell.urlimage.downloadImage(from: (self.articles[indexPath.item].urlimage)!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.articles.count) - 1{
            
        }
    }
    
   
    
    @IBAction func MoreLinkClicked(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "MoreLinkVC", sender: urlvalue)
    }


    
    var getname = String()
    var getid = String()
    var articles: [Article] = []
    
    
   var jsonURL = String()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         NSLog("searchbarclicked")
        searchBar.resignFirstResponder()
        
        let text = searchBar.text
        jsonURL = commonurl + "everything?q=\(text!)&" + apiKey
       // let request = URLRequest(url: jsonURL!)
       self.loadtabledata()
        print("urltext:", jsonURL)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.rechability = Reachability.init()
        
        if ((self.rechability!.connection) != .none){
        // Do any additional setup after loading the view.
        
       // print("url:", getid)
        
         self.navigationItem.title = getname
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
     
          jsonURL = commonurl + "top-headlines?sources=\(getid)&" + apiKey
        
            searchBar.text = ""
        
       print("urlpressed:", jsonURL)
      
        
        
             self.loadtabledata()
       
        
        }else {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }
    }
    
    func loadtabledata(){
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
                        self.articles.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.activity.stopAnimating()
                }
                
                
            }catch  let jsonErr{
                print("Erro serializing json:", jsonErr)}
        }; task.resume()
       
    }
  /*  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.performSegue(withIdentifier: "MorelinkVC", sender: urlvalue)

       // let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let Dvc = Storyboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
      //  Dvc.url = self.articles[indexPath.item].url
        
       // self.navigationController?.pushViewController(Dvc, animated: true)
        
        
       // self.performSegue(withIdentifier: "MorelinkVC", sender: url)
        
    }*/
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc =  segue.destination as! WebviewViewController
        vc.url = sender as? String
        
        // Determine what the segue destination is
        
        if segue.identifier == "MoreLinkVC"
        {
       
                let vc =  segue.destination as? WebviewViewController
            vc?.url = urlvalue
            
        
        
               // vc?.url = "Arthur Dent"
            
          
            print("urlfinalvalue:", urlvalue)
            
       
            
            
            
        }
    }
}

    //  let index = self.collectionView.indexPathsForSelectedItems?.url
    //Dvc.url = self.articles[indexPath.item].url
    // Pass the selected object to the new view controller.



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
        }else{
            print("image not availble")
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


