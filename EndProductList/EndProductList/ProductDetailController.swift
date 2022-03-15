//
//  ProductDetailController.swift
//  EndProductList
//
//  Created by kiranjith on 10/03/2022.
//

import UIKit
import SDWebImage

public protocol ProductDetailControllerDelegate: AnyObject {
    func navigateToFirstPage()
}

class ProductDetailController: UIViewController {
    
    private var product: Product
    
    public weak var delegate: ProductDetailControllerDelegate?
    private  lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "return")
        return imageView
    }()
    
    private  lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Helvetica-Nueu", size: 20)
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Nueu", size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "DESCRIPTION:\n\nRefine your casual looks with this clay-coloured hoody from AMIRI. It’s cut to a boxy fit for a laid-back look, while its premium cotton construction ensures a super-soft feel."
        label.frame.size.width = 300
        label.sizeToFit()
        return label
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Yellow"
        label.font = UIFont(name: "Helvetica-Nueu", size: 20)
        label.textColor = .lightGray
        return label
    }()
    
    private  lazy var productStake: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = product.name
        view.backgroundColor = .white
        customizeBackButton()
        setupSUbviews()
        
    }
    private  func  customizeBackButton() {
        let imgBackArrow = UIImage(systemName: "chevron.backward")
        imgBackArrow?.withRenderingMode(.alwaysTemplate)
        
        let backButton: UIButton = UIButton()
        backButton.setImage(imgBackArrow, for: .normal)
        backButton.addTarget(self, action:#selector(backButtonTapped), for: UIControl.Event.touchUpInside)
        backButton.tintColor = .black
        let leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    
    private func setupSUbviews() {
        guard let url = URL(string: product.image) else {
            return
        }
        self.productImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"), options: SDWebImageOptions.progressiveLoad, context: nil)
        
        productStake.addArrangedSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.5)
            
        }
        productStake.addArrangedSubview(titleLabel)
        productStake.addArrangedSubview(colorLabel)
        productStake.addArrangedSubview(priceLabel)
        productStake.addArrangedSubview(descriptionLabel)
        productStake.addArrangedSubview(UIView())
        
        
        
        view.addSubview(productStake)
        productStake.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(10)
        }
        
        titleLabel.text = product.name
        priceLabel.text = product.price
        priceLabel.snp.makeConstraints {make in
            make.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints {make in
            make.height.equalTo(20)
        }
        colorLabel.snp.makeConstraints {make in
            make.height.equalTo(20)
        }
    }
    
}

extension ProductDetailController {
    @objc func backButtonTapped() {
        self.delegate?.navigateToFirstPage()
    }
    
    
}
