//
//  CheckEnteredWord.swift
//  Navigation
//
//  Created by TIS Developer on 28.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
class CheckEnteredWord {
    
    private let correctWord = "Тест"
    
    func checkWord(enteredWord: String?, onChecked: (Bool) -> Void) -> Void {
        onChecked(enteredWord == correctWord)
    }
}
