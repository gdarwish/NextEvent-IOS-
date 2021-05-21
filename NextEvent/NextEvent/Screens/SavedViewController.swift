//
//  SavedViewController.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-24.
//

import UIKit
import CoreData


class SavedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var savedEvents = [EventModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        // load events
        loadEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // add animation to tableView
        animateTable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // set tableview delegate, dataSourcedataSource
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadEvents(){
        // fetch events
        let request : NSFetchRequest<EventModel> = EventModel.fetchRequest()
        do{
            // add to savedEvents array
            savedEvents = try context.fetch(request)
        }catch{
            print("Error")
        }
        tableView.reloadData()
    }
    
    func deleteEvent(event: EventModel, index: Int){
        context.delete(event)
        savedEvents.remove(at: index)
        do{
            try context.save()
        }
        catch{
            print("Error \(error.localizedDescription)")
        }
        // reloadData
        tableView.reloadData()
    }
    
    func animateTable(){
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}

extension SavedViewController: UITableViewDelegate{
    
}

extension SavedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        // get event index
        let event = self.savedEvents[indexPath.row]
        cell.title.text = event.title
        cell.address.text = event.address
        cell.country.text = event.country
        cell.date.text = event.date
        cell.img?.loadImage(imgUrl: URL(string: event.image)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // delete event
            deleteEvent(event: savedEvents[indexPath.row], index: indexPath.row)
        }
    }
}
