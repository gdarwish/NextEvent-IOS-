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
//         get events when the app runs
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
            
            self.filterEventByContry(countrySearched: (textField?.text)!)
        }))
        self.present(ac, animated: true)
    }
    
    // The API returns the first 2 letters of the County name EX(CA for Canada)
    // this methde returns the full name of the country
    func getCountryName() -> String{
        for event in events{
            for county in Countries.allCases{
                if event.country.lowercased() == county.rawValue.lowercased(){
                    return county.name
                }
            }
        }
        return "No Name"
    }
    
    func filterEventByContry(countrySearched: String){
        events.removeAll()
        var found = false
        for county in Countries.allCases{
            if countrySearched.lowercased() == county.name.lowercased(){
                // show error
                found = true
                print(county.rawValue)
                getEvent(country: county.rawValue)
                break
            }
        }
        if !found {
            alert(message: "'\(countrySearched)' was not found!")
        }
    }
    
    // Create an alert with dynamic message
    func alert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // pull data from API OR get data when searching
    func getEvent(search: String = "", country: String = "US"){
        // show spinner
        self.showSpinner()
        // API URL
        if let url = URL(string: "https://api.predicthq.com/v1/events/?q=\(search)&country=\(country)") {
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
                        print("Error here \(error.localizedDescription)")
                    }
                    DispatchQueue.main.sync {
                        if self.events.isEmpty{
                            print("Error")
                        }
                        // reloadData tableView
                        self.tableView.reloadData()
                        // remove the spinner
                        self.removeSpinner()
                    }
                }
            }.resume()
        }else{
            self.removeSpinner()
            alert(message: "'\(search)' was not found!")
        }

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("NAVIGATE")
//
//        if let vc = segue.destination as? DetailEventViewController {
////            vc.detailEvent = events[0]
//
//            if let index = tableView.indexPathForSelectedRow?.row {
//                vc.detailEvent = events[index]
//
//                print("HERE")
//
//            }
//        }
//    }
}
extension UpcomingViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailEventViewController{
            vc.detailEvent = events[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
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
        cell.address.text = "2124 Mark Ave"
        
//        cell.address.text = getAddress()
//        print("getAddress  \(event.getAddress())")
        
        cell.country.text = getCountryName()
        cell.date.text = event.dateFormatted()
        cell.img?.loadImage(imgUrl: URL(string: event.getImage())!)
        return cell
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
