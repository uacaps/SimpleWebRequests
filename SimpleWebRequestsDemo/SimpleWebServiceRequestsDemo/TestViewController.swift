//
//  TestViewController.swift
//  SimpleWebServiceRequestsDemo
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
        
        
        
        // Web calls are as easy as the commented out call below and only your resources need to be set up for this to work!
//        let resource = AddArticlesResource()
//        let body = Article(title: "Test 1", description: "Testing article description.")
//        resource.setBody(body: JSONCoder.encode(object: body)) // optional
//        resource.setQuery(query: "?something=something") // optional
//        let _ = NetworkDataRequest(resource: resource).load { (response) in
//            switch response {
//            case let .success(model):
//                self.textView.text = "Title: \(model.title)\nDescription: \(model.description)"
//            case let .error(error):
//                print("ERROR OH NO!!! \(error)")
//            default:
//                return
//            }
//        }
        
        // Example doing all leg work in controller regarding the resource setup
//        let resource = GetArticlesResource()
//        resource.setBody(body: JSONCoder.encode(object: body)) // optional
//        resource.setQuery(query: "?something=something") // optional
//        let _ = MyDataRequestManager.shared.loadRequest(with: resource) { (response) in
//            switch response {
//            case let .success(model):
//                var text = ""
//                model.forEach { text += "Title: \($0.title)\nDescription: \($0.description)\n\n" }
//                self.textView.text = text
//            case let .error(error):
//                print("ERROR OH NO!!! \(error)")
//            default:
//                return
//            }
//        }
        
        // Example representing wrapper functions doing the resource setup and representing more closely the type of request that is made in the function signature
        let _ = MyDataRequestManager.shared.getArticles { (model, error) in
            if let error = error {
                switch error {
                case URLError.notConnectedToInternet:
                    print("You are not connected to the internet")
                default:
                    print("Error: \(error)")
                }
            } else if let model = model {
                var text = ""
                model.forEach { text += "Title: \($0.title)\nDescription: \($0.description)\n\n" }
                self.textView.text = text
            }
        }
    }
    
    @IBAction func didTapMakePostWebCall(_ sender: Any) {
        self.textView.text = "Making post request..."

        // Non working example, but this is how you set the body on a request that requires one like a post request
        
//        let body = Roll(id: 1, name: "Beast")
//        var resource = AddRollResource()
//        resource.setBody(body: JSONCoder.encode(object: body))
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
