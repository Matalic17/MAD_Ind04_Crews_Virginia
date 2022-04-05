//
//  TableViewController.swift
//  MAD_Ind04_lastName_firstName
//
//  Created by Virginia Crews on 4/5/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
        //private var laoding = true
        //private var stateCount = 50
    
        // First, a structure to hold the decoded JSON data.
        struct states: Decodable {
            var name: String
            var nickname: String
        
        }
    
    var stateArray: [states] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        
        // As of iOS 9, this URL must use HTTPS rather than HTTP.
        let urlString =  "https://cs.okstate.edu/~vcrews/states.php"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        // The method dataTask(with:) specifies a completion closure;
        // it is invoked asynchronously when the call to the service
        // returns.
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
          // Check to see if any error was encountered.
          guard error == nil  else {
            print("URL Session error: \(error!)")
            return
          }
          // Check to see if we received any data.
          guard let data = data else {
            print("No data received")
            return
          }
            do {
                let json = try JSONDecoder().decode([states].self,
                  from: data)
                print(json)
                self.stateArray = json
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
              } catch let error as NSError {
                print("Error serializing JSON Data: \(error)")
              }
            }  // End of closure
            // Execute the task.
            task.resume()

            
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    return stateArray.count
    }

    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableCell", for: indexPath)

        // Configure the cell...
    cell.textLabel?.text = stateArray[indexPath[1]].name
    cell.detailTextLabel?.text = stateArray[indexPath[1]].nickname
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
