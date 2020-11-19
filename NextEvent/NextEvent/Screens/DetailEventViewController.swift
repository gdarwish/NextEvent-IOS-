//
//  DetailEventViewController.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-18.
//

import UIKit
import SafariServices


class DetailEventViewController: UIViewController {
    
    //MARK:: Outlets
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var detailEvent: Event!

    
    //MARK:: Methods
    @IBAction func MoreInfoButton(_ sender: Any) {
        if let url = URL(string: "https://www.google.com/search?rls=en&q=") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
        }
    
    @IBAction func saveButton(_ sender: Any) {
    }
    
    
    @IBAction func directionsButton(_ sender: Any) {
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // set border on buttons view
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        
    }
}
