//
//  BusinessTableViewCell.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    var type: BusinessCategory?
    
    //MARK: - Outlets
    @IBOutlet weak var businessCellView: UIView!
    @IBOutlet weak var contentCellView: UIView!
    
    @IBOutlet weak var headerCellView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessAddresLabel: UILabel!
    @IBOutlet weak var businessImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add the shadow to the outerView
        businessCellView.backgroundColor = UIColor.clear
        businessCellView.layer.shadowColor = UIColor.gray.cgColor
        businessCellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        businessCellView.layer.shadowOpacity = 0.75
        businessCellView.layer.shadowRadius = 5
        
        // add the corner radius to innerView
        contentCellView.layer.cornerRadius = 5
        contentCellView.layer.borderColor = UIColor.black.cgColor
        contentCellView.layer.borderWidth = 0
        contentCellView.layer.masksToBounds = true
        
        distanceLabel.textColor = .white
        categoryImage.image?.withRenderingMode(.alwaysTemplate)
        arrowImageView.image?.withRenderingMode(.alwaysTemplate)
        
        businessImage.image = UIImage(named: "only image")
    }

    
    func configureCell(business: BusinessModel){
        businessNameLabel.text = business.name
        if let address = business.address {
            self.businessAddresLabel.text = address
        }
        distanceLabel.text = getDistanceString(distance: business.distance)
        if let icon = business.category?.iconWhite {
            self.categoryImage?.image = UIImage(named: icon)
        }
        headerCellView.backgroundColor = business.category?.color ?? .gray
        
        getBusinessLogo(urlString: business.logo)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    //MARK: - Helpers
    
    private func getDistanceString(distance: Double) -> String? {
        let distInt = Int(distance)
        return "\(distInt) m."
    }
    
    private func getBusinessLogo(urlString: String?) {
        if let imageUrl = urlString, let url = URL(string: imageUrl) {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.businessImage.image = image
                self.businessImage.contentMode = .scaleAspectFit
                
            }
        }
    }
}
