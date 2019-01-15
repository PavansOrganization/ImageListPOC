//
//  ImageListViewController.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SnapKit

class ImageListViewController: UIViewController {
    
    // MARK: UI Components
    var containerView = UIView()
    var collectionView: UICollectionView!
    let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    var layout: PinterestStyleFlowLayout = {
        let layout = PinterestStyleFlowLayout()
        layout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
        return layout
    }()
    
    // MARK: Internals
    var imageDataViewModel = ImageDataViewModel()
    private var cellsSizes = [CGSize]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
        configureAcivityIndicatorView()
        closureSetUp()
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: View Cinfigurations Methods
    /*
     Configuring base view,
     by adding constraints on it, by using snapkit framework.
     Addiing refresh button on navigation bar for re-fetching the data from server.
     */
    
    private func configureView() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.navigationItem.rightBarButtonItem = refreshButton
        self.view.addSubview(containerView)
        self.view.backgroundColor = .white
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    /*
     Configuring AcivityIndicator by adding constraints on it, by using snapkit framework
     */
    private func configureAcivityIndicatorView() {
        
        activityView.center = self.view.center
        activityView.color = .black
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        
        self.activityView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
    }
    
    // MARK: UI Methods
    private func closureSetUp() {
        imageDataViewModel.reachability = {
            Utility.showAlert(message: AppConstants.connectionError, delegate: self)
            self.activityView.stopAnimating()
        }
        
        imageDataViewModel.reloadList = {
            DispatchQueue.main.async {
                self.activityView.stopAnimating()
                self.title = self.imageDataViewModel.getScreenTitle()
                self.cellsSizes = CellSizeProvider.provideSizes(items: self.imageDataViewModel.rowsArray)
                self.collectionView.reloadData()
            }
        }
    }
    
    /*
     Configuring collectionview by adding constraints on it, by using snapkit framework.
     Also it sets the delegate and datasource to the controller.
     */
    private func configureCollectionView() {
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.delegate = self
        self.collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
        
        self.collectionView.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.collectionView.dataSource = self
        self.collectionView?.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.ID)
        collectionView.reloadData()
    }
    
    @objc func refresh() {
        self.activityView.startAnimating()
        imageDataViewModel.prepareToCallFactDataAPI()
    }
}

extension ImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataViewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.imageDataViewModel.currentItem = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.ID, for: indexPath) as? ImageCollectionViewCell
        cell?.configureCell(viewModel: self.imageDataViewModel)
        return cell!
    }
}

extension ImageListViewController: ContentDynamicLayoutDelegate {
    func cellSize(indexPath: IndexPath) -> CGSize {
        return cellsSizes[indexPath.row]
    }
}
