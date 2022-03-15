//
//  ProductCell.swift
//  EndProductList
//
//  Created by kiranjith on 11/03/2022.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell, Listable {
    typealias ListableItem = Product
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "return")
        return imageView
    }()
    
    private  lazy var produtStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var produtInfoStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        
        view.alignment = .leading
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Yellow"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var favouriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(priceLabel)
        let view  = UIView()
        
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stack.addArrangedSubview(view)
        stack.addArrangedSubview(favouriteIcon)
        return stack
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private  func setupSubviews() {
        self.addSubview(produtStack)
        self.addSubview(productImageView)
        produtInfoStack.addArrangedSubview(titleLabel)
        produtInfoStack.addArrangedSubview(colorLabel)
        produtStack.addArrangedSubview(produtInfoStack)
        produtStack.addArrangedSubview(priceStack)
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {make in
            make.height.equalTo(13)
        }
        
        produtStack.snp.makeConstraints { make in
            make.top.equalTo(self.productImageView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        priceStack.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
        
        
    }
    
    func listItem(item: Product) {
        self.titleLabel.text = item.name
        self.priceLabel.text = item.price
        guard let url = URL(string: item.image) else {
            return
        }
        let image = UIImage(systemName: "photo")
        image?.withRenderingMode(.alwaysTemplate)
        self.productImageView.sd_setImage(with: url, placeholderImage: image, options: SDWebImageOptions.progressiveLoad, context: nil)
        
        
    }
}
