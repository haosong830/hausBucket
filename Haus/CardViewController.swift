//
//  ViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 6/29/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var CollectView: UICollectionView!
    //var ImageArray=[UIImage(named: "1.jpg"), UIImage(named: "1.jpg")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.PhotoView.image=DataArray[indexPath.row].image
        cell.TextInfo.text=DataArray[indexPath.row].text
        return cell
    }
    
    @IBAction func UpdateImages(_ sender: Any) {
        //ImageArray.append(UIImage(named: "1.jpg"))
        updateimage()
        
    }
    
    @objc func updateimage(){
        CollectView.reloadData()
    }
    func InsertImage(){
        let insertIndexPath=IndexPath(item:0, section:0)
        CollectView.insertItems(at: [insertIndexPath])
        
        updateimage()
        
    }
    func DeleteImage(index: Int){
        let indexPath=IndexPath(item: index, section: 0)
            DataArray.remove(at: indexPath.item)
            CollectView?.deleteItems(at: [indexPath])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(updateimage), name: NSNotification.Name("Update"), object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

