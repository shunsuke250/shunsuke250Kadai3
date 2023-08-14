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

    enum Operator {
        case plus
        case minus

        init(isOn: Bool) {
            if isOn {
                self = .minus
            } else {
                self = .plus
            }
        }

        func evaluate(value: Int) -> Int {
            switch self {
            case .minus:
                return -value
            case .plus:
                return value
            }
        }
    }

    struct CalculationResult {
        let firstValue: Int
        let secondValue: Int

        var answerValue: Int {
            firstValue + secondValue
        }
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

    func calculate(num1: Int, num2: Int) -> CalculationResult {
        CalculationResult(
            firstValue: Operator(isOn: firstSwitch.isOn).evaluate(value: num1),
            secondValue: Operator(isOn: secondSwitch.isOn).evaluate(value: num2)
        )
    }

    @IBAction func didTapCalculateButton(_ sender: Any) {
        guard let text1 = firstTextField.text,
              let num1 = Int(text1),
              let text2 = secondTextField.text,
              let num2 = Int(text2)
        else {
            answerLabel.text = "整数値を入力してください"
            return
        }

        let result = calculate(num1: num1, num2: num2)
        answerLabel.text = "\(result.answerValue)"
        firstLabel.text = "\(result.firstValue)"
        secondLabel.text = "\(result.secondValue)"
    }
}
