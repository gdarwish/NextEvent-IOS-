//
//  UpcomingViewController.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-10-29.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    // MARK:: Properties
    @IBOutlet weak var tableView: UITableView!
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "City", style: .plain, target: self, action: #selector(addTapped))

        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    // MARK:: Methods
    @objc func addTapped(){
        //1. Create the alert controller.
        let ac = UIAlertController(title: "Change City", message: "Enter a new city", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ac.addTextField { (textField) in textField.text = "Windsor"}
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak ac] (_) in
            let textField = ac?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
        }))
        self.present(ac, animated: true)
    }
}

extension UpcomingViewController: UITableViewDelegate{
    
}

extension UpcomingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        
        cell.title.text = "Hello"
        cell.address.text = "21243 Mark"
        cell.date.text = "10-10-2020"
        cell.img?.loadImage(imgUrl: URL(string: "https://pbs.twimg.com/profile_images/758084549821730820/_HYHtD8F.jpg")!)
        return cell
    }
}

// create UIImageView extension
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
