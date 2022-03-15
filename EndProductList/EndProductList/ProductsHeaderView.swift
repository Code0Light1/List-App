//
//  ProductsHeaderView.swift
//  EndProductList
//
//  Created by kiranjith on 14/03/2022.
//

import UIKit

protocol HeaderItemPresentable {
    var title: String {get}
    func headerAction()
}

class HeaderItem : HeaderItemPresentable {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func headerAction() {
        print("Action")
    }
}

protocol HideAnimatable {
    var hideView: Bool  {
        get set
    }
}

class ProductsHeaderView: UIView {
    
    
    private var options: [HeaderItemPresentable] = []
    
    private lazy var productOptionsStack: UIStackView = {
        let stack  = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.addArrangedSubview(optionsStack)
        return stack
    }()
    
    
    private  lazy var optionsStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 1
        stack.distribution = .fillEqually
        return stack
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let sort = HeaderItem(title: "Sort")
        let view = HeaderItem(title: "View")
        let filter = HeaderItem(title: "Filter")
        options.append(contentsOf: [sort, view, filter])
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(red: 248/255, green: 246/255, blue: 248/255, alpha: 1.0)
        self.addSubview(optionsStack)
        for item in options {
            let label = UILabel()
            label.text = item.title
            label.backgroundColor = .white
            label.textAlignment = .center
            optionsStack.addArrangedSubview(label)
            
        }
        optionsStack.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview().inset(1)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
    
    
}
