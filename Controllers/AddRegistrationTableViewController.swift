//
//  AddRegistrationTableViewController.swift
//  hotelProject
//
//  Created by Burak Kara on 28.10.2022.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController,SelectedRoomTypeTableViewControllerDelegate{

   // MARK: UI Elements
    
    @IBOutlet var firstNameTextField:UITextField!
    @IBOutlet var lastNameTextField:UITextField!
    @IBOutlet var emailTextField:UITextField!
    
    @IBOutlet var checkInDateLabel:UILabel!
    @IBOutlet var checkInDatePicker:UIDatePicker!
    @IBOutlet var checkOutDateLabel:UILabel!
    @IBOutlet var checkOutDatePicker:UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel:UILabel!
    @IBOutlet var numberOfAdultsStepper:UIStepper!
    
    @IBOutlet var numberOfChildrenLabel:UILabel!
    @IBOutlet var numberOfChildrenStepper:UIStepper!
    
    @IBOutlet var wifiSwitch:UISwitch!
    
    @IBOutlet var roomTypeLabel:UILabel!

    // MARK:  Properties
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    
    var isCheckInDatePickerShown:Bool=false{
        didSet{
            checkInDatePicker.isHidden  = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown:Bool=false{
        didSet{
            checkOutDatePicker.isHidden  = !isCheckOutDatePickerShown
        }
    }
    
    var roomType : RoomType?
    
    var registration: Registration?{
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi=wifiSwitch.isOn
        
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
        
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
         
        checkInDatePicker.minimumDate = midnightToday
        
        checkInDatePicker.date = midnightToday
        
        updateNumberOfGuest()
        
        updateDateViews()

        updateRoomType()
    }
    
    
    // MARK: Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destination = segue.destination as? SelectedRoomTypeTableViewController
            destination?.delegate = self
            destination?.selectedRoomType = roomType
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown{
                return 216
            }else{
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown{
                return 216
            }else{
                return 0
            }
            
        default:
            return 54
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown{
                isCheckInDatePickerShown=false
            }else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown=false
                isCheckInDatePickerShown=true
            }else {
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
            
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown{
                isCheckOutDatePickerShown=false
            }else if isCheckInDatePickerShown {
                isCheckInDatePickerShown=false
                isCheckOutDatePickerShown=true
            }else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
        
    }

    func updateDateViews(){

        let oneDay : Double = 24 * 60 * 60
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        
        
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = .medium
        
        
        checkInDateLabel.text=dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text=dateFormatter.string(from: checkOutDatePicker.date)

    }
    func updateNumberOfGuest(){
        numberOfAdultsLabel.text="\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text="\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType(){
        
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }else {
            roomTypeLabel.text = "Not Set"
        }
        
    }

    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    // MARK: Actions
    @IBAction func cancelBarButtonTapped(_ button:UIBarButtonItem){
        dismiss(animated: true,completion: nil)
    }

    @IBAction func datePickerValueChanged(_ picker:UIDatePicker){
        
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ stepper:UIStepper){
        
        updateNumberOfGuest()
    }
    
    @IBAction func wifiSwitchChanged(_ sender:UISwitch){
        
        //
    }
}
