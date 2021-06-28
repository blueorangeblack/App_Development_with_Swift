//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by min on 2021/06/05.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {

    var emoji: Emoji?
    
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let emoji = emoji { //emoji가 있으면
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
        }
        
        updateSaveButtonState()
        //viewDidLoad에서 이 메소드를 호출하는 이유 (내 생각)
        //1) 셀을 선택해서 넘어온거면 아마도 빈 값이 없을 거긴 하지만 사용자가 입력폼을 이용해서 추가한 게 아니라 이미 저장된 데이터를 불러오는 경우 emojis에 빈값을 넣었을 수도 있고 (지금은 그런 일 없긴 하지만)
        //2) +버튼을 선택해서 넘어온거면 처음에 모든 TextField가 비어있기 때문에 Save Button을 비활성화해야하는데 처음에 viewDidLoad에서 이 메소드를 호출하지 않으면 TextField가 비어있는데도 Save Button이 활성화되기때문에
    }
    
    //TextField가 빈 값인지 확인해서 모든 TextField에 값이 있을 때 saveButton이 활성화되도록
    func updateSaveButtonState() {
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        // textField의 빈 값이 있는지 확인하는 것
        // ""는 Empty 이다!!
        saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
      
        //TextField의 text가 빈 값인지 확인하는 걸 TextField의 text를 바로 검사하면 안되나?
        //text뒤에 !붙이라고 경고가 나와서 붙이면
        //!symbolTextField.text!.isEmpty 이렇게 하면 되는데 빈값일 때 !해버려서 크래쉬인가?
        //===> 실행해보면 괜찮은데... 코드가 좀 복잡하기도 하고, 좀 안전하게 하기 위함인가..?
        //나머지 코드들도 더 추가해봤을 때 다시 실행해서 확인해보고, 더 생각해볼 필요있음
        //saveButton.isEnabled = !symbolTextField.text!.isEmpty && !nameTextField.text!.isEmpty && !descriptionTextField.text!.isEmpty && !usageTextField.text!.isEmpty
    }
    
    //TextField의 데이터값이 바뀔 때마다 호출되는 메소드
    //4개의 TextField가 모두 빈 값이 아니면 Save Button이 활성화되고
    //하나라도 빈값이 있으면 Save Button이 비활성화됨
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //(강의-super를 왜 호출하지? unwind라서 특별한가? 이걸 해주는 걸 본적없다고하심)
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        
        emoji = Emoji(symbol: symbolText, name: nameText, description: descriptionText, usage: usageText)
        //이렇게 만들어 두면 EmojiTableView에서 읽어감
    }

}
