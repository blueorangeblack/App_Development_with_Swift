//
//  AddRegistrationTableViewController.swift
//  ComplexInputScreensHotelManzana
//
//  Created by Minju Lee on 2021/06/26.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType: RoomType?
    
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfchildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firtsName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildresn: numberOfchildren, rommType: roomType, wifi: hasWifi)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //오늘의 자정 0시 0분 0초
        let midnightToday = Calendar.current.startOfDay(for: Date())
        //checkInDatePickr의 minimumDate는 오늘 자정
        checkInDatePicker.minimumDate = midnightToday
        //checkOutDatePickr의 date는 일단 오늘 자정으로 설정하고 (+ 안해도 되는 거 아닌가?)
        checkOutDatePicker.date = midnightToday
        //checkOutDatePickr의 minimumDate는 checkInDate보다 하루(86400초)지난 시점으로 설정
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        //강좌에는 없는데 추가해주는 게 좋을 듯
        //==> 아 근데 처음에는 날짜가 비어있어서 아무것도 안나오고 valueChange method가 바로 적용안됨
//        let dateFormatter = DateFormatter()
//        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
//        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
        updateNumberOfGuest()
        
        updateRoomType()
    }
    
    //DatePicker 2개가 다 연결됨
    @IBAction func datePickerValueChanged(_ sender: Any) {
        //Layout Driven UI (애플의 코딩 제안)
        //UI를 업데이트하는 방식 - 번거롭지만 깔끔한 UI update방식
        updateDateViews()
    }
    
    func updateDateViews() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        //강좌에는 없는데 추가해주는 게 좋을 듯
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        updateNumberOfGuest()
    }
    
    func updateNumberOfGuest() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch  indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            //static table view에서는 reloadData를 쓸 수 없어서 함수 따로 호출해야 함
            tableView.beginUpdates()
            tableView.endUpdates()
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            //static table view에서는 reloadData를 쓸 수 없어서 함수 따로 호출해야 함
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
        
        //static table view에서는 reloadData를 쓸 수 없어서 함수 따로 호출해야 함
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
}
