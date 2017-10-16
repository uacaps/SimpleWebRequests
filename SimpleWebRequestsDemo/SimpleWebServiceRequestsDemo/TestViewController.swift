//
//  TestViewController.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/12/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapMakeWebCall(_ sender: Any) {
        self.textView.text = "Making get request..."
        
        let resource = GetArticlesResource()
        
        // Web calls are as easy as the commented out call below and only your resources need to be set up for this to work!
        
//        let _ = NetworkDataRequest(resource: resource).load { (response) in
//            switch response {
//            case let .success(model):
//                self.textView.text = "Id: \(model.id)\nName: \(model.name)"
//            case let .error(error):
//                print("ERROR OH NO!!! \(error)")
//            default:
//                return
//            }
//        }
        
        let _ = MyDataRequestManager.shared.loadRequest(with: resource) { (response) in
            switch response {
            case let .success(model):
                var text = ""
                model.forEach { text += "Title: \($0.title)\nDescription: \($0.description)\n\n" }
                self.textView.text = text
            case let .error(error):
                print("ERROR OH NO!!! \(error)")
            default:
                return
            }
        }
    }
    
    @IBAction func didTapMakePostWebCall(_ sender: Any) {
        self.textView.text = "Making post request..."

        // Non working example, but this is how you set the body on a request that requires one like a post request
        
//        let body = Roll(id: 1, name: "Beast")
//        var resource = AddRollResource()
//        resource.setBody(body: JSONCoder().encode(object: body))
//        let _ = NetworkDataRequest(resource: resource).load { (response) in
//            switch response {
//            case let .success(model):
//                self.textView.text = "Id: \(model.id)\nName: \(model.name)"
//            case let .error(error):
//                print("ERROR OH NO!!! \(error)")
//            default:
//                return
//            }
//        }
    }
}
