//
//  CollectionViewCell.swift
//  CalculatorApp
//
//  Created by ToshiPro01 on 2022/06/03.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 32)
        label.clipsToBounds = true
        label.backgroundColor = .orange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(numberLabel)
        numberLabel.frame.size = self.bounds.size
        numberLabel.layer.cornerRadius = self.bounds.height / 2
    }
    
    override var isHighlighted: Bool{
        didSet {
            if isHighlighted {
                numberLabel.alpha = 0.3
            }else{
                numberLabel.alpha = 1.0
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
