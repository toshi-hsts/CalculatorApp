//
//  ViewController.swift
//  CalculatorApp
//
//  Created by ToshiPro01 on 2022/06/03.
//

import UIKit

class ViewController: UIViewController {
    enum CalculateStatus {
        case none, plus
    }
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calculatorCollectionView: UICollectionView!
    @IBOutlet weak var calculatorHeightConstraint: NSLayoutConstraint!
    
    let numbers = [
        ["C","%","$","+"],
        ["7","8","9","×"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".","="],
    ]
    
    var firstNumber = ""
    var secondNumber = ""
    var calcurateStatus: CalculateStatus = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorCollectionView.delegate = self
        calculatorCollectionView.dataSource = self
        calculatorCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        calculatorHeightConstraint.constant = view.frame.width * 1.4
        calculatorCollectionView.backgroundColor = .clear
        calculatorCollectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
        view.backgroundColor = .black
    }
    
    private func clear(){
        numberLabel.text = "0"
        calcurateStatus = .none
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbers[indexPath.section][indexPath.row]
        
        if calcurateStatus == .none {
            switch number {
            case "0"..."9":
                numberLabel.text = number
            case "+":
                firstNumber = numberLabel.text ?? ""
                calcurateStatus = .plus
            case "C":
                clear()
            default:
                break
            }
        } else if calcurateStatus == .plus{
            switch number {
            case "0"..."9":
                numberLabel.text = number
            case "=":
                secondNumber = numberLabel.text ?? ""
                
                let firstNum = Double(firstNumber) ?? 0
                let secondNum = Double(secondNumber) ?? 0
                numberLabel.text = String(firstNum + secondNum)
            case "C":
                clear()
            default:
                break
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calculatorCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        
        numbers[indexPath.section][indexPath.row].forEach { numberString in
            if "0"..."9" ~= numberString || numberString.description == "."{
                cell.numberLabel.backgroundColor = .darkGray
            }else if numberString == "C" || numberString == "%" || numberString == "$"{
                cell.numberLabel.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
                cell.numberLabel.textColor = .black
            }
        }
        
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = 0
        width = ((collectionView.frame.width - 10) - 14 * 5) / 4
        let height = width
        if indexPath.section == 4 && indexPath.row == 0{
            width = width * 2 + 14 + 9
        }
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}
