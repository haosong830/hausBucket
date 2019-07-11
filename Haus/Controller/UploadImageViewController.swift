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
    
    
    func PostData() {
        
        let urluploadaddress=backendip+"/api/tags"
        let url = URL(string: urluploadaddress)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "tag": TextField.text,
            "image": "icecream.jpg"
        ]
        
        print(parameters.percentEscaped().data(using: .utf8)!)
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
        }
        task.resume()
        
    }
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
