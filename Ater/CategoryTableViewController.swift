//
//  CategoryTableViewController.swift
//  Ater
//
//  Created by Boris Angelov on 11/19/16.
//  Copyright © 2016 Boris Angelov. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    public var categories = [Category]()
    public var contents: (restaurantId: Int, tableId: Int)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RestaurantService.setup(restaurantId: self.contents!.restaurantId, tableId: self.contents!.tableId)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleCategoriesLoaded), name: .onCategoriesLoaded, object: nil)
        RestaurantService.loadCategories()
    }
    
    @objc private func handleCategoriesLoaded(notification: Notification) {
        self.categories = notification.object as! [Category]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell

        // Configure the cell...
        cell.nameLabel.text = self.categories[indexPath.row].name
        cell.bgImageView.getImgFromUrl(link: categories[indexPath.row].image, contentMode: .scaleAspectFill)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productsController = segue.destination as? ProductTableViewController {
            if let selectedCategoryCell = sender as? CategoryTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCategoryCell)!
                let category = self.categories[indexPath.row]
                productsController.category = category
            }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
