//
//  ViewController.swift
//  ApplePie
//
//  Created by min on 2021/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    //플레이어가 유추할 단어
    var listOfWords = ["finn", "jake", "bmo", "bubblegum", "marceline", "ladyrainicorn", "iceking", "lsp"]
    
    //목숨 x 7
    let incorrectMovesAllowed = 7
    
    //전체 승과 패의 개수를 관리
    var totalWins = 0{
        //값이 변경되면 newRound 호출
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        //값이 변경되면 newRound 호출
        didSet{
            newRound()
        }
    }
    
    //Game struct의 인스턴스
    var currentGame:Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    //새로운 단어를 찾고, 시도한 횟수를 초기화
    //listOfWords에서 하나를 꺼내고, currentGame을 새로 만드는 작업
    func newRound(){
        //게임에서 이기든 지든 새로운 게임을 시작하도록 newRound()함수를 통해서 새로운 게임이 나와야 하고
        //listOfWords의 단어를 다 썼을 때 처리를 해줘야 함
        //listOfWords가 비어있지 않다면
        if !listOfWords.isEmpty {
            //첫 번째 걸 꺼내면서 그 array에서는 삭제하는 방식으로 뽑아 냄
            let newWord = listOfWords.removeFirst()
            //currentGame을 초기화
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            //모든 버튼을 활성화
            enableLetterButtons(true)
            updateUI()
        } else { //listOfWords가 비어있다면
            //모든 버튼을 비활성화
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable:Bool) {
        //모든 버튼에 대해서 활성화, 비활성화해야 하기 때문에
        //letterButtons 에서 하나씩 꺼내서
        //매개변수로 넘어온 enable Bool값으로 활성화상태를 설정
        for letter in letterButtons {
            letter.isEnabled = enable
        }
    }
    
    //UI를 업데이트하는 메소드
    //(UI를 업데이트하는 함수를 이렇게 따로 두는 건 굉장히 좋은 방식!)
    //(나중에 UI를 업데이트해야하는 모든 순간에 이 함수만 호출하면 됨)
    func updateUI(){
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
        //correctWordLabel에 한 문자씩 띄어쓰기되도록하기
        var letters = [String]()
        for letter in currentGame.formattedWord{
            //letter의 type은 let letter: String.Element이라서
            //letters라는 array에 추가하려면
            //letter를 letters에 추가하는 방법 1)
            //문자열보간
            //letters.append("\(letter)")
            //letter를 letters에 추가하는 방법 2)
            //String으로 형변환
            letters.append(String(letter))
        }
        //공백(빈칸)으로 letters Array를 분리
        let wordWithSpacing = letters.joined(separator: " ")
        
        //띄어쓰기 없는 Label
        //correctWordLabel.text = currentGame.formattedWord
        //띄어쓰기 있는 Label
        correctWordLabel.text = wordWithSpacing
    }

    //버튼을 누르면 누른 버튼을 비활성화 시키고, 게임의 상태도 업데이트
    @IBAction func buttonTapped(_ sender: UIButton) {
        //버튼을 누르면 그 버튼을 비활성화하고
        sender.isEnabled = false
        //그 버튼의 normal 상태일 때의 글자를 letterString 변수에 담고
        let letterString = sender.title(for: .normal)!
        //비교를 쉽게 하기위해 lowercase로 바꾼 것을 letter 변수에 담고
        let letter = Character(letterString.lowercased())
        //letter를 currentGame.playerGuessed에 추가하고
        currentGame.playerGuessed(letter: letter)
        //updateUI를 호출해서 UI를 갱신
        //updateUI() updateGameState에서 updateUI하니까 주석처리
        updateGameState()
    }
    
    func updateGameState(){
        //incorrectMovesRemaining이 0이면 게임에서 지고
        //word와 formattedWord가 같으면 이김
        //그래서 formattedWord에서 빈칸을 넣어서 " _ "로 추가하면 꼬이게 돼서
        //updateUI에서 따로 wordWithSpacing를 만들었던 것
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else { //위의 두 경우 이외에는 게임이 진행중이니까
            updateUI()
        }
    }
}
