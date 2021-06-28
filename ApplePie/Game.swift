//
//  Game.swift
//  ApplePie
//
//  Created by min on 2021/05/23.
//

import Foundation

//구조체를 만들어서 한 라운드의 게임 데이터를 관리하도록 하기
struct Game {
    //유추할 단어
    var word:String
    //남은 목숨
    var incorrectMovesRemaining:Int
    //사용자가 유추한 알파벳들을 전부 다 하나하나 보관하고 있도록 Character 배열 만들기
    var guessedLetters: [Character]
    
    //correctWordLabel에 표시할 글자
    var formattedWord: String {
        var guessedWord = ""
        //유추할 단어를 알파벳 하나씩 쪼개서 for문으로 guessedLetters에 있는지 확인해서
        //있으면 그 알파벳을 표시하고 없으면 _로 표시
        for letter in word {
            //잘 맞추면
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    //함수안에서 guessedLetters를 변경하기 때문에
    //func앞에 mutating을 붙여야 함
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        //word가 letter를 가지고 있으면
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
}
