//
//  ViewController.swift
//  TableJson
//
//  Created by Arun kumar Sah on 1/25/17.
//  Copyright © 2017 Arun kumar Sah. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
      var tableView: UITableView  =   UITableView()
    var customView = UIView()
    let urlstring = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    
    var nameArray = [String]()
    var dobArray = [String]()
    var imgURLArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJsonWithURL()
        customView.frame = CGRect(x:0,y: 0,width: 200,height: 50)
        customView.backgroundColor = UIColor.red
        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.grouped)
        tableView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = customView
        //tableView.tableFooterView?.isHidden = false
        
        //tableView.tableHeaderView = customView
        self.view.addSubview(self.tableView)
        
        
        self.tableView.separatorColor = UIColor.blue
        //self.tableView.separatorStyle = .singleLineEtched
        self.tableView.separatorStyle = .singleLine
        // Do any additional setup after loading the view, typically from a nib.
    }
    


    func downloadJsonWithURL() {
        let url = URL(string: urlstring)
        URLSession.shared.dataTask(with: ((url)! as URL), completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!)
                
                if let actorArray = jsonObj!.value(forKey: "actors") as? NSArray {
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let name = actorDict.value(forKey: "name") {
                                self.nameArray.append(name as! String)
                            }
                            if let name = actorDict.value(forKey: "dob") {
                                self.dobArray.append(name as! String)
                                print(self.dobArray)
                            }
                            if let name = actorDict.value(forKey: "image") {
                                self.imgURLArray.append(name as! String)
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        }).resume()
    }
    
//    func downloadJsonWithTask() {
//        
//        let url = URL(string: urlstring)
//        
//        var downloadTask = URLRequest(url: (url! as URL), cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
//        
//        downloadTask.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
//            
//            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//            
//            print(jsonData!)
//            
//        }).resume()
//    }




    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }



    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!as UITableViewCell
        cell.textLabel?.text = nameArray[indexPath.row]
       
        
        cell.detailTextLabel?.text =  dobArray[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.imageView?.image = UIImage(data: data as! Data)
        }
        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! ViewController
//        vc.imageString = imgURLArray[indexPath.row]
//        vc.nameString = nameArray[indexPath.row]
//        vc.dobString = dobArray[indexPath.row]
//        
//        self.navigationController?.pushViewController(vc, animated: true)
         }

}


