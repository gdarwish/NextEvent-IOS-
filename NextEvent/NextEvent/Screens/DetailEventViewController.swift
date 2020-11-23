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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MapViewController {
            vc.detailEvent = self.detailEvent
        }
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        // text to share
        let title = detailEvent.title
        let date = detailEvent.dateFormatted()
        let message = "Check this event out: \(title) that's going to be hold on \(date)"

        // set up activity view controller
        let textToShare = [ message ]
        
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        // exclude some activity types from the list
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        self.present(activityViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add event data
        image.loadImage(imgUrl: URL(string: detailEvent.getImage())!)
        titleLabel.text = detailEvent.title
        dateLabel.text = detailEvent.dateFormatted()
        addressLabel.text = "2124 Mark"
        descriptionLabel.text =  detailEvent.description
       
        // set border on buttons view
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        
    }
}
