//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by min on 2021/06/04.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A Confused, puzzled face.", usage: "what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z's.", usage: "tired,sleepiness")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        //이거 없으면 Edit버튼 눌렀을 때 Edit버튼이 Done이라는 글자로 안바뀜
        //근데 스토리보드에서도 똑같이 왼쪽에 바버튼아이템을 추가했는데 충돌나지는 않나? 모르겠다
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //테이블뷰의 높이를 자동으로
        tableView.rowHeight = UITableView.automaticDimension
        //예상하는 높이 값이 얼마인지 주는 것
        tableView.estimatedRowHeight = 44.0
    }
    
    //여기서는 없어도 괜찮은 거 같긴함..!
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        //현재 Editing상태 Bool값
        let tableViewEditingMode = tableView.isEditing
        //현재 Editing상태가 false이면 true로 setEditing하고
        //현재 Editing상태가 true이면 false로 setEditing하도록
        //현재의 반대값으로 셋팅 !tableViewEditingMode
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //없으면 만들거라는 코드가 아래 코드에 내재되어있음. 따로 안써도 됨
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.row]
        /* CustomCell만들어서 이건 필요없음. 삭제해도 됨
        cell.textLabel?.text = "\(emoji.symbol) = \(emoji.name)"
        cell.detailTextLabel?.text = emoji.description
         */
        cell.update(with: emoji)
        
        //셀에 재정렬 컨트롤이 표시되는지 여부를 결정하는 값을 true로 설정
        cell.showsReorderControl = true
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    //이 메소드가 없으면 왼쪽에 표시되는 -모양 delete control(?)을 눌러도 아무 반응없음
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //emojis에서 그 오브젝트도 삭제하고
            emojis.remove(at: indexPath.row)
            // Delete the row from the data source
            //테이블뷰에서 row도 삭제하기
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //위 코드나 tableView.reloadData()가 없으면 오른쪽에 생기는 Delete버튼을 눌러도 삭제가 안됨.
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
        //tableView의 셀을 바꾸는 게 아니라 데이터를 바꾸는 거니까 reloadData() 해야한다는데...
        //(+ reloadData()안해도 테이블 뷰에서도 순서 잘바뀌고, emojis에서도 순서가 잘 바뀌어있는데,, 안해도 결과는 같은데 꼭 해야하는 건가?)
    }
 
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    @IBAction func unwindToEmojiTableView(_ unwindSegue: UIStoryboardSegue) {
        //segue는 saveUnwind여야 하고
        //sourceViewController는 AddEditEmojiTableViewController여야 하고
        //sourceViewController에서 emoji를 가져올 수 있어야 함
        //안되면 return
        guard unwindSegue.identifier == "saveUnwind",
              let sourceViewController = unwindSegue.source as? AddEditEmojiTableViewController,
              let emoji = sourceViewController.emoji else { return }
        
        //셀을 선택해서 넘어간 경우
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //수정을 했든 안했든 업데이트
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }else { //+버튼을 눌러서 넘어간 경우
            //emojis.count 갯수를 이용해서 먼저 newIndexPath를 만든 후에 emojis에 append
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            //맨 뒤에 추가
            emojis.append(emoji)
            //맨 앞에 추가 (원하는 곳에 추가)
            //emojis.insert(emoji, at: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            let navigationController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navigationController.topViewController as! AddEditEmojiTableViewController
            addEditEmojiTableViewController.emoji = emoji
        } else {
            //identifier가 EditEmoji가 아니라면 비어있는 폼
        }
    }
}
