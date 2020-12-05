//
//  numb4Tests.swift
//  numb4Tests
//
//  Created by Adele Fatkullina on 24.10.2020.
//  Copyright © 2020 Adele Fatkullina. All rights reserved.
//

import XCTest
//существование основного модуля
@testable import numb4

class numb4Tests: XCTestCase {
//
    var sut: ViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       // super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut = vc as? ViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
       // sut = nil
       // super.tearDown()
    }

    func testLowestLengthSB3() {
        //given
        let password = "oh"
        //when
        sut.checkValidation(password: password)
        let comm = sut.warnLabel.text
        //then
        XCTAssert(comm == "Некорректное число символов", "Минимальное чиcло символов должно равняться 3")
    }
    
    func testHighestLengthSB32() {
        //given
        let password = "howManySymbolsOhMyGodnessNoGodPleaseStopIt..."
        //when
        sut.checkValidation(password: password)
        let comm = sut.warnLabel.text
        
        XCTAssert(comm == "Некорректное число символов", "Максимальное чило символов должно равняться 32")
    }
    
    func testFirstCharSNBSpecial() {
        //given
        let password = ".leeeeeeel"
        //when
        sut.checkValidation(password: password)
        let comm = sut.warnLabel.text
        
        XCTAssert(comm == "Логин может состоять из латинских \nбукв, цифр и символов (- .)\nЛогин не может начинаться \nна цифру или специальный символ.", "Логин не может начинаться на специальный символ")
    }
    
    func testLoginSILatinAlphabet() {
        //given
        let password = "тычедядя"
        //when
        sut.checkValidation(password: password)
        let comm = sut.warnLabel.text
        
        XCTAssert(comm == "Логин может состоять из латинских \nбукв, цифр и символов (- .)\nЛогин не может начинаться \nна цифру или специальный символ.", "Логин не может содержать никакой алфавит кроме латинского")
    }
    
    func testLoginSIOnly2KindOfSpecialSymbols() {
        //given
        let password = "rukiddingmef#@&%!"
        //when
        sut.checkValidation(password: password)
        let comm = sut.warnLabel.text
        
        XCTAssert(comm == "Логин может состоять из латинских \nбукв, цифр и символов (- .)\nЛогин не может начинаться \nна цифру или специальный символ.", "Логин не может содержать символы кроме - и .")
    }
    
    func testLoginSBCorrect() {
        //given
        let password = "ItsMyLogin-.09"
        //when
        sut.checkValidation(password: password)
        let comm = sut.warnLabel.text
        
        XCTAssert(comm == "Введенные данные корректны", "Логин введен некорректно")
    }
    
    func testEmailSBCorrect() {
        //given
        let password = "mymail@bk.ru"
        //when
        sut.checkValidation(password: password)
        let comm = sut.warnLabel.text
        
        XCTAssert(comm == "Введенные данные корректны", "Почта введена некорректно")
    }
    
   
}
