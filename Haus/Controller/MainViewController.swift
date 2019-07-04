//
//  MainViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 6/30/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit





var DataArray=[DataInfo]()


class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData(latitude: 35.047278, longitude: -85.3078294)
        print(DataArray.count)
        //GetData(latitude: 0, longitude:0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddImages(_ sender: Any) {
        DataArray.insert(DataInfo(longitude:0, latitude:0, altitude:0, text:"All your Bases Are Belong to US", image: UIImage(named: "1.jpg")!), at: 0)
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    

    func GetData(latitude: Double, longitude: Double){
         var tags=[Tag]()
        DataArray.removeAll()
        let latitudeinstring=String(latitude)
        let longitudeinstring=String(longitude)
        //let jsonURLString="http://localhost/api/tags?latitude=35.047278&longitude=-85.3078294"
        

    let jsonURLString="http://localhost/api/tags?latitude="+latitudeinstring+"&longitude="+longitudeinstring
        
        guard let url=URL(string: jsonURLString) else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            
            if let err=err{
                print ("Failed to get data from url:", err)
                return
            }
            guard let data=data else{
                return
            }
            do{
                let decoder=JSONDecoder()
                tags=try decoder.decode([Tag].self, from: data)
                print(tags[0].text)
                print(tags[0].latitude)
                
                for tag in tags{
                    DataArray.insert(DataInfo(longitude:tag.latitude, latitude:tag.longitude, altitude:0, text: tag.text, image: UIImage(named: "1.jpg")!), at: 0)
                    
                }
                
                NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
            }catch let jsonErr{
                print (jsonErr)
            }
            }.resume()

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
