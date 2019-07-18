//
//  UploadImageViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 7/10/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit

class UploadImageViewController: UIViewController {

    @IBOutlet weak var TextField: UITextView!
    @IBOutlet weak var Uploadimage: UIImageView!
    var image:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Uploadimage.image=image

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ReturnToCamera(_ sender: Any) {
        PostData()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func PostData(){
        
               let urluploadaddress=backendip+"/api/tags"
                let url = URL(string: urluploadaddress)!
                var r = URLRequest(url: url)
       // let urluploadaddress=backendip+"/api/tags"
       // var r  = URLRequest(url: URL(string: "http://localhost/api/tags")!)
        r.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let RandomString=randomString(length: 5)+".jpg"
        let params: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "tag": TextField.text,
            "image": RandomString
        ]
        
        let chosenImage=Uploadimage.image
        r.httpBody = createBody(parameters: params ,
                                boundary: boundary,
                                data: UIImageJPEGRepresentation(chosenImage!, 0.7)!,
                                mimeType: "multipart/form-data",
                                filename: RandomString)
        let task = URLSession.shared.dataTask(with: r) { (data, response, error) in
            if (error==nil){
                
            }else{
                print (error)
            }
            
        }
        task.resume()
        
        
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    func createBody(parameters: [String: Any],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
//    func PostData() {
//
//        let urluploadaddress=backendip+"/api/tags"
//        let url = URL(string: urluploadaddress)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let parameters: [String: Any] = [
//            "latitude": latitude,
//            "longitude": longitude,
//            "tag": TextField.text,
//            "image": "icecream.jpg"
//        ]
//
//        print(parameters.percentEscaped().data(using: .utf8)!)
//        request.httpBody = parameters.percentEscaped().data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//
//        }
//        task.resume()
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
