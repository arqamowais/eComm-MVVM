//
//  ProductCell.swift
//  eComm-MVVM
//
//  Created by Arqam Owais on 18/04/2023.
//

import Foundation
import UIKit

final class ProductCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var productBackgroundView: UIView!
    @IBOutlet private var productImageView: UIImageView!
    @IBOutlet private var productTitleLabel: UILabel!
    @IBOutlet private var productCategoryLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var rateButton: UIButton!
    
    // MARK: - Variables
    
    var product: Product? {
        didSet {
            productDetailConfiguration()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15
        productBackgroundView.backgroundColor = .systemGray6
        
        productImageView.layer.cornerRadius = 10
    }
    
    private func productDetailConfiguration() {
        guard let product else {
            return
        }
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
    
}
