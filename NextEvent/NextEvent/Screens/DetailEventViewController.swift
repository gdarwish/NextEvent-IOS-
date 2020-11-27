//
//  DetailEventViewController.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-18.
//

import UIKit
import SafariServices
import CoreData


class DetailEventViewController: UIViewController {
    
    //MARK:: Outlets
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var detailEvent: Event!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    
    //MARK:: Methods
    @IBAction func MoreInfoButton(_ sender: Any) {
        // title
        let title = detailEvent.title
        // replace space with %20 for Google search
        let urlSearch = title.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: "https://www.google.com/search?source=h&q=\(urlSearch)") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
        }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let newEvent = EventModel(context: self.context)
        newEvent.id = detailEvent.id
        newEvent.title = detailEvent.title
        newEvent.descriptionEvent = detailEvent.description
        newEvent.date = detailEvent.dateFormatted()
        newEvent.address = detailEvent.address
        newEvent.image = detailEvent.getImage()
        newEvent.country = countryLabel.text!
        newEvent.latitude = detailEvent.getLatitude()
        newEvent.longitude = detailEvent.getLongitude()
        
        do{
            try self.context.save()
        }catch{
            print("Error \(error.localizedDescription)")
        }
        let ac = UIAlertController(title: "NextEvent", message: "New Event Saved!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(ac, animated: true)
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
        let message = "Check this event out: \(title) that's going to be hold on \(getCountryName()) at: \(date)"

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
        addressLabel.text = detailEvent.address
        if detailEvent.description.isEmpty{
            descriptionText.text = "No Description!"
            
        }else{
            descriptionText.text =  detailEvent.description
        }
        countryLabel.text = getCountryName()
       
        // set border on buttons view
        buttonsView.layer.borderWidth = 0.5
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    func getCountryName() -> String{
            for county in Countries.allCases{
                if detailEvent.country.lowercased() == county.rawValue.lowercased(){
                    return county.name
                }
            }
        return "No Name"
    }
}
