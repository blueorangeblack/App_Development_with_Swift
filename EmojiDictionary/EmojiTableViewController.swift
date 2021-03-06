//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by min on 2021/06/04.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] = [
        Emoji(symbol: "๐", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "๐", name: "Confused Face", description: "A Confused, puzzled face.", usage: "what to think; displeasure"),
        Emoji(symbol: "๐", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "๐ค", name: "Snore", description: "Three blue \'z's.", usage: "tired,sleepiness")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        //์ด๊ฑฐ ์์ผ๋ฉด Edit๋ฒํผ ๋๋ ์ ๋ Edit๋ฒํผ์ด Done์ด๋ผ๋ ๊ธ์๋ก ์๋ฐ๋
        //๊ทผ๋ฐ ์คํ ๋ฆฌ๋ณด๋์์๋ ๋๊ฐ์ด ์ผ์ชฝ์ ๋ฐ๋ฒํผ์์ดํ์ ์ถ๊ฐํ๋๋ฐ ์ถฉ๋๋์ง๋ ์๋? ๋ชจ๋ฅด๊ฒ ๋ค
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //ํ์ด๋ธ๋ทฐ์ ๋์ด๋ฅผ ์๋์ผ๋ก
        tableView.rowHeight = UITableView.automaticDimension
        //์์ํ๋ ๋์ด ๊ฐ์ด ์ผ๋ง์ธ์ง ์ฃผ๋ ๊ฒ
        tableView.estimatedRowHeight = 44.0
    }
    
    //์ฌ๊ธฐ์๋ ์์ด๋ ๊ด์ฐฎ์ ๊ฑฐ ๊ฐ๊ธดํจ..!
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        //ํ์ฌ Editing์ํ Bool๊ฐ
        let tableViewEditingMode = tableView.isEditing
        //ํ์ฌ Editing์ํ๊ฐ false์ด๋ฉด true๋ก setEditingํ๊ณ 
        //ํ์ฌ Editing์ํ๊ฐ true์ด๋ฉด false๋ก setEditingํ๋๋ก
        //ํ์ฌ์ ๋ฐ๋๊ฐ์ผ๋ก ์ํ !tableViewEditingMode
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
        //์์ผ๋ฉด ๋ง๋ค๊ฑฐ๋ผ๋ ์ฝ๋๊ฐ ์๋ ์ฝ๋์ ๋ด์ฌ๋์ด์์. ๋ฐ๋ก ์์จ๋ ๋จ
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.row]
        /* CustomCell๋ง๋ค์ด์ ์ด๊ฑด ํ์์์. ์ญ์ ํด๋ ๋จ
        cell.textLabel?.text = "\(emoji.symbol) = \(emoji.name)"
        cell.detailTextLabel?.text = emoji.description
         */
        cell.update(with: emoji)
        
        //์์ ์ฌ์ ๋ ฌ ์ปจํธ๋กค์ด ํ์๋๋์ง ์ฌ๋ถ๋ฅผ ๊ฒฐ์ ํ๋ ๊ฐ์ true๋ก ์ค์ 
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

    //์ด ๋ฉ์๋๊ฐ ์์ผ๋ฉด ์ผ์ชฝ์ ํ์๋๋ -๋ชจ์ delete control(?)์ ๋๋ฌ๋ ์๋ฌด ๋ฐ์์์
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //emojis์์ ๊ทธ ์ค๋ธ์ ํธ๋ ์ญ์ ํ๊ณ 
            emojis.remove(at: indexPath.row)
            // Delete the row from the data source
            //ํ์ด๋ธ๋ทฐ์์ row๋ ์ญ์ ํ๊ธฐ
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //์ ์ฝ๋๋ tableView.reloadData()๊ฐ ์์ผ๋ฉด ์ค๋ฅธ์ชฝ์ ์๊ธฐ๋ Delete๋ฒํผ์ ๋๋ฌ๋ ์ญ์ ๊ฐ ์๋จ.
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
        //tableView์ ์์ ๋ฐ๊พธ๋ ๊ฒ ์๋๋ผ ๋ฐ์ดํฐ๋ฅผ ๋ฐ๊พธ๋ ๊ฑฐ๋๊น reloadData() ํด์ผํ๋ค๋๋ฐ...
        //(+ reloadData()์ํด๋ ํ์ด๋ธ ๋ทฐ์์๋ ์์ ์๋ฐ๋๊ณ , emojis์์๋ ์์๊ฐ ์ ๋ฐ๋์ด์๋๋ฐ,, ์ํด๋ ๊ฒฐ๊ณผ๋ ๊ฐ์๋ฐ ๊ผญ ํด์ผํ๋ ๊ฑด๊ฐ?)
    }
 
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    @IBAction func unwindToEmojiTableView(_ unwindSegue: UIStoryboardSegue) {
        //segue๋ saveUnwind์ฌ์ผ ํ๊ณ 
        //sourceViewController๋ AddEditEmojiTableViewController์ฌ์ผ ํ๊ณ 
        //sourceViewController์์ emoji๋ฅผ ๊ฐ์ ธ์ฌ ์ ์์ด์ผ ํจ
        //์๋๋ฉด return
        guard unwindSegue.identifier == "saveUnwind",
              let sourceViewController = unwindSegue.source as? AddEditEmojiTableViewController,
              let emoji = sourceViewController.emoji else { return }
        
        //์์ ์ ํํด์ ๋์ด๊ฐ ๊ฒฝ์ฐ
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //์์ ์ ํ๋  ์ํ๋  ์๋ฐ์ดํธ
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }else { //+๋ฒํผ์ ๋๋ฌ์ ๋์ด๊ฐ ๊ฒฝ์ฐ
            //emojis.count ๊ฐฏ์๋ฅผ ์ด์ฉํด์ ๋จผ์  newIndexPath๋ฅผ ๋ง๋  ํ์ emojis์ append
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            //๋งจ ๋ค์ ์ถ๊ฐ
            emojis.append(emoji)
            //๋งจ ์์ ์ถ๊ฐ (์ํ๋ ๊ณณ์ ์ถ๊ฐ)
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
            //identifier๊ฐ EditEmoji๊ฐ ์๋๋ผ๋ฉด ๋น์ด์๋ ํผ
        }
    }
}
