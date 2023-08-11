//
//  ViewController.swift
//  Calculator23-08-11
//
//  Created by 副山俊輔 on 2023/08/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var firstSwitch: UISwitch!
    @IBOutlet private weak var secondSwitch: UISwitch!
    @IBOutlet private weak var calculateButton: UIButton!
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var answerLabel: UILabel!

    enum Error: Swift.Error {
        case invalidSwitchState
        case invalidInputNum
    }

    enum Operator {
        static let plus = false
        static let minus = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.text = ""
        secondLabel.text = ""
        answerLabel.text = ""
        calculateButton.setTitle("計算", for: .normal)
        firstSwitch.isOn = false
        secondSwitch.isOn = false
        firstTextField.keyboardType = .numberPad
        secondTextField.keyboardType = .numberPad
    }

    func calculate(num1: Int, num2: Int) throws -> (Int, Int) {
        switch (firstSwitch.isOn, secondSwitch.isOn) {
        case (Operator.plus, Operator.plus):
            return (num1, num2)
        case (Operator.plus, Operator.minus):
            return (num1, -num2)
        case (Operator.minus, Operator.plus):
            return (-num1, num2)
        case (Operator.minus, Operator.minus):
            return (-num1, -num2)
        default:
            throw Error.invalidSwitchState
        }
    }
    
    @IBAction func didTapCalculateButton(_ sender: Any) {
        guard let text1 = firstTextField.text,
              let num1 = Int(text1),
              let text2 = secondTextField.text,
              let num2 = Int(text2)
        else {
            return answerLabel.text = "整数値を入力してください"
        }
        do {
            let answer = try calculate(num1: num1, num2: num2)
            answerLabel.text = "\(answer.0 + answer.1)"
            firstLabel.text = "\(answer.0)"
            secondLabel.text = "\(answer.1)"
        } catch {
            print("Fatal Error: 計算に失敗しました")
        }
    }
}

