//
//  ViewController.swift
//  numb4
//
//  Created by Adele Fatkullina on 24.10.2020.
//  Copyright © 2020 Adele Fatkullina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var nickTextField: UITextField!
    
    private let minLength = 3
    private let maxLength = 32
    
  
    private lazy var regex = "^([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}@([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}\\.([a-z0-9]){2,64}$|^([A-Za-z]){1,1}([A-Za-z0-9-.]){\(minLength-1),\(maxLength-1)}$"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        nickTextField.delegate = self
        warnLabel.numberOfLines = 0
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
     func checkValidation(password: String) {
        guard password.count >= minLength && password.count <= maxLength else {
            
            warnLabel.text = "Некорректное число символов"
            warnLabel.textColor = .red
            return
        }
        
        if password.matches(regex) {
            warnLabel.textColor = .blue
            warnLabel.text = "Введенные данные корректны"
        } else {
            warnLabel.textColor = .systemRed
            warnLabel.text = "Логин может состоять из латинских \nбукв, цифр и символов (- .)\nЛогин не может начинаться \nна цифру или специальный символ."
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    //срабатывает при удалении и добавлении символа (проверка на валидность)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text ?? "") + string
        let res: String
        //при удалении range = 1
        if range.length == 1 {
        
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            res = String(text[text.startIndex..<end])
        } else {
            res = text
        }
        
        checkValidation(password: res)
        
        textField.text = res
        return false
    }
   
}

//
extension String {
    func matches(_ regex: String) -> Bool {
        //есть вхождение в строку которое соответствует регулярному выр-ю или нет
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
