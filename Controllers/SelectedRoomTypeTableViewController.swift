//
//  SelectedRoomTypeTableViewController.swift
//  hotelProject
//
//  Created by Burak Kara on 10.11.2022.
//

import UIKit

protocol SelectedRoomTypeTableViewControllerDelegate: class {
    
    func didSelect(roomType: RoomType)
}

class SelectedRoomTypeTableViewController: UITableViewController {

    // MARK: UI Elements
    
    
     // MARK:  Properties

    var selectedRoomType: RoomType?
    weak var delegate:SelectedRoomTypeTableViewControllerDelegate?
    
     // MARK: Life Cycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

     // MARK: Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
  
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell")!
            let roomType = RoomType.all[indexPath.row]
            
            cell.textLabel?.text = roomType.name
            cell.detailTextLabel?.text = "$ \(roomType.price)"
            
        if roomType == selectedRoomType {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }

            return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: selectedRoomType!)
        tableView.reloadData()
    }

    // MARK: Action

}
     

