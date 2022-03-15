//
//  ViewController.swift
//  EndProductList
//
//  Created by kiranjith on 10/03/2022.
//

import UIKit
import SnapKit

protocol ProductListControllerDelegate: AnyObject {
    func navigateToNextPage(withProduct product: Product)
}

class ProductListController: UIViewController{
    
    private  lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        return collectionView
    }()
    
    public weak var delegate: ProductListControllerDelegate?
    private var lastContentOffset: CGFloat = 0
    private  lazy var productHeader = ProductsHeaderView()
    private  lazy var productFooter = ProductsFooterView()
    
    private var productViewModel: ProductsViewModel = ProductsViewModel()
    private var productDataSource: CollectionDataSource<ProductCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDataSource =  CollectionDataSource(collectionView: productCollectionView, cellReuseIdentifier: "ProductCell")
        productCollectionView.dataSource = productDataSource?.makeDataSource()
        view.backgroundColor = .white
        view.addSubview(productCollectionView)
        self.productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.productCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        self.productCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(1)
        }
        
        productViewModel.products.bind { products in
            self.productDataSource?.add(products)
        }
        self.productViewModel.onErrorHandling = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        self.productViewModel.fetchProducts()
        setupSUbview()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupSUbview() {
        self.title = "Products"
        let header = ProductsHeaderView()
        productHeader = header
        view.addSubview(productHeader)
        productHeader.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
        }
        productFooter = ProductsFooterView()
        view.addSubview(productFooter)
        productFooter.snp.makeConstraints{ make in
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
}

private enum LayoutConstant {
    static let spacing: CGFloat = 10.0
    static let itemHeight: CGFloat = 200.0
}
extension ProductListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    private  func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    
}

extension ProductListController: UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = self.productDataSource?.items
        let product = items?.value[indexPath.row]
        if let product = product {
            self.delegate?.navigateToNextPage(withProduct: product)
        }
        
    }
}

extension ProductListController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
            productFooter.isHidden = false
            productHeader.isHidden = false
            //
        } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
            productFooter.isHidden = true
            productHeader.isHidden = true
            
        }
        // update the new position acquired
        lastContentOffset = scrollView.contentOffset.y
    }
}

