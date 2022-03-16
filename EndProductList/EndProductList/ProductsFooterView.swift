//
//  ProductsHeaderView.swift
//  EndProductList
//
//  Created by kiranjith on 14/03/2022.
//

import UIKit
//Abstractions used to create dynamic footer options
protocol FooterItemPresentable {
    var image: UIImage {get}
    func headerAction()
}

class FooterItem : FooterItemPresentable {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func headerAction() {
        print("Action")
    }
}

protocol FooterPresentable {
    var options: [FooterItemPresentable] {
        get set
    }
}

class ProductsFooterView: UIView {
    private var options: [FooterItemPresentable] = []
    
    private lazy var optionsStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 1
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let glass = UIImage(systemName: "magnifyingglass") {
            let search = FooterItem(image: glass)
            options.append(search)
        }
        if let heart =  UIImage(systemName: "heart") {
            let wishlist = FooterItem(image: heart)
            options.append(wishlist)
        }
        if let end =  UIImage(named: "end") {
            let end = FooterItem(image: end)
            options.append(end)
        }
        if let profile = UIImage(systemName: "person") {
            let profile = FooterItem(image: profile)
            options.append(profile)
        }
        if let bag = UIImage(systemName: "bag") {
            let cart = FooterItem(image: bag)
            options.append(cart)
        }
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private  func setupSubviews() {
        self.backgroundColor = .white
        self.addSubview(optionsStack)
        for item in options {
            let view = UIView()
            let imageView = UIImageView()
            imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.black
            imageView.image = item.image
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .white
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            optionsStack.addArrangedSubview(view)
        }
        
        optionsStack.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview().inset(1)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
}
