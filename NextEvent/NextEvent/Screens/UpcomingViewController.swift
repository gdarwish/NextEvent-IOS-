//
//  UpcomingViewController.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-10-29.
//

import UIKit
import Foundation


class UpcomingViewController: UIViewController {
    
    // MARK:: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var events = [Event]()
    var filteredEvents = [Event]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        // get events when the app runs
        getEvent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set tableView delegate and dataSource
        tableView.delegate = self
        tableView.dataSource = self
        // set search delegate
        searchBar.delegate = self
    }
    
    // MARK:: Methods
    
    // change city bar button
    @IBAction func changeCity(_ sender: Any) {
        //1. Create the alert controller.
        let ac = UIAlertController(title: "Change City", message: "Enter a new city", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ac.addTextField { (textField) in textField.text = "Canada"}
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak ac] (_) in
            let textField = ac?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            
            self.filterEventByContry(contry: (textField?.text)!)
            
        }))
        self.present(ac, animated: true)
    }
    
    func filterEventByContry(contry: String){
            
    }
    
    // Create an alert with dynamic message
    func alert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // pull data from API OR get data when searching
    func getEvent(search: String = ""){
        // show spinner
        self.showSpinner()
        // API URL
        let url = URL(string: "https://api.predicthq.com/v1/events/?q=\(search)")!
        var request = URLRequest(url: url)
        // API Headers
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer l5V8mMsVhA99CwkPxc7T2E9IU_SCxzJPxQDdqQua",
            "Accept": "application/json"
        ]
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print("Error \(error.localizedDescription)")
            }else{
                do{
                    // get data from result
                    guard let jData = data else {return}
                    // create jsonDecoder
                    let jsonDecoder = JSONDecoder()
                    // get the results and decode Event from jData
                    let jResult = try jsonDecoder.decode(Result.self, from: jData)
                    // add the results to the events array
                    self.events = jResult.results
                }catch let error{
                    // if any error
//                    self.alert(message: "No Result Found!")
                    print("Error here \(error.localizedDescription)")
                }
                DispatchQueue.main.sync {
                    if self.events.isEmpty{
                        self.alert(message: "No Result Found!")
                    }
                    // reloadData tableView
                    self.tableView.reloadData()
                    // remove the spinner
                    self.removeSpinner()
                }
            }
        }.resume()
    }
}

extension UpcomingViewController: UITableViewDelegate{
    
}

extension UpcomingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        // get event index
        let event = self.events[indexPath.row]
        cell.title.text = event.title
        cell.address.text = event.country
        cell.date.text = event.start
        cell.img?.loadImage(imgUrl: URL(string: event.getImage())!)
        return cell
    }
}

extension UIImageView{
    // create loadImage function that's used to load the image from url
    func loadImage(imgUrl: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imgUrl){
                if let image = UIImage(data: data){
                    DispatchQueue.main.sync {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UpcomingViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // // get searched text
        guard let searchText = searchBar.text else {return}
        // pull events from API with the searched text
        getEvent(search: searchText)
        // resign keyboard
        searchBar.resignFirstResponder()
    }
}
