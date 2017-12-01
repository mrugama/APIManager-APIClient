//
//  ViewController.swift
//  URLSessionNasa
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class NasaViewController: UIViewController {

    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var NASAImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var nasaObject: NasaObject? {
        didSet {
            if let nasaObject = nasaObject {
                self.titleLabel.text = nasaObject.titleText
                loadImage(from: nasaObject.hdurlStr ?? nasaObject.urlStr)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spiner.isHidden = true
    }
    
    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        let selectedDate = datePicker.date
        let longDescription = selectedDate.description
        let ymd = longDescription.components(separatedBy: " ")[0]
        loadObject(for: ymd)
    }
    
    func loadImage(from urlStr: String) {
        self.spiner.isHidden = false
        self.spiner.startAnimating()
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {return}
            self.NASAImageView.image = onlineImage
            self.NASAImageView.setNeedsLayout()
            self.spiner.stopAnimating()
            self.spiner.isHidden = true
        }
        let errorHandler: (Error) -> Void = {(_) in
            self.NASAImageView.image = #imageLiteral(resourceName: "NoImageAvailable")
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }

    func loadObject(for YMD: String) {
        let myKey = "3tAMWEJY01N2L8lXx4QAvpryfScrpefiYDronWsD"
        let str = "https://api.nasa.gov/planetary/apod?date=\(YMD)&api_key=\(myKey)"
        let completion: (NasaObject) -> Void = {(onlineObject: NasaObject) in
            self.nasaObject = onlineObject
        }
        let errorHandler: (Error) -> Void = {(Error) in
            let alert = UIAlertController(title: "Error", message: "An error has occurred", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        NasaObjectAPIClient.manager.getNasaObject(from: str, completionHandler: completion, errorHandler: errorHandler)
    }

}

