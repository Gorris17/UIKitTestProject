//
//  CategoryCellCollectionViewCell.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import UIKit

public protocol CategoryCellProtocol {
    func categorySelected(type: BusinessCategory)
}

class CategoryCellCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    var delegate: CategoryCellProtocol?
    var type: BusinessCategory?

    //MARK: - Outlets
    @IBOutlet weak var categoryCellView: UIView!
    @IBOutlet weak var contentCellView: UIView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add the shadow to the outerView
        categoryCellView.backgroundColor = UIColor.clear
        categoryCellView.layer.shadowColor = UIColor.gray.cgColor
        categoryCellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        categoryCellView.layer.shadowOpacity = 0.75
        categoryCellView.layer.shadowRadius = 5
        
        // add the corner radius to innerView
        contentCellView.layer.cornerRadius = 5
        contentCellView.layer.borderColor = UIColor.black.cgColor
        contentCellView.layer.borderWidth = 0
        contentCellView.layer.masksToBounds = true
    }

    
    
    
    func configureCell(type: BusinessCategory, selected: Bool){
        self.type = type
        categoryTitle.text = type.rawValue
        categoryTitle.textColor = type.color
        categoryIcon.image = UIImage(named: type.iconColor)
        isSelected = selected
        updateColor()
    }
    
    private func updateColor() {
        contentCellView.backgroundColor = isSelected ? .gray : .white
    }
    
    //MARK: - Actions
    @IBAction func selectCategory(_ sender: Any) {
        isSelected.toggle()
        updateColor()
        delegate?.categorySelected(type: type ?? .none)
    }

}
