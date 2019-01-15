//
//  ImageDataViewModel.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class ImageDataViewModel {
    
    var reloadList = { () -> Void in }
    var reachability = { () -> Void in }
    
    private var factTitle = String()
    var currentItem: Int = 0
    
    var rowsArray = [Rows]() {
        didSet {
            self.reloadList()
        }
    }
    
    private let imageDataAPI: WebService
    
    init(api: WebService = ImageDataAPI()) {
        imageDataAPI = api
    }
    
    // MARK: Public Data Method
    
    func getScreenTitle() -> String {
        return self.factTitle
    }
    
    func getImageTitle() -> String {
        return self.rowsArray[currentItem].title ?? ""
    }
    
    func getImageDescription() -> String {
        return self.rowsArray[currentItem].description ?? ""
    }
    
    func getImageURL() -> URL? {
        guard self.rowsArray.count > 0 else {
            return nil
        }
        return URL(string: self.rowsArray[currentItem].imageHref ?? "")
    }
    
    func numberOfItems() -> Int {
        return rowsArray.count
    }
}

extension ImageDataViewModel {
    func prepareToCallFactDataAPI() {
        if Network.connectedToNetwork() {
            self.callFactsAPI()
        } else {
            self.reachability()
        }
    }
    
    private func callFactsAPI() {
        imageDataAPI.getFactsData { (factsData, message) in
            if let errorMessage = message {
                Utility.showAlert(message: errorMessage, delegate: nil)
                return
            }
            
            guard let rows = factsData?.rows else {
                self.rowsArray = []
                return
            }
            
            self.factTitle = factsData?.title ?? ""
            self.rowsArray = rows
            self.filterRowsArray()
        }
    }
    
    /*
     Removing objects whose title, description and imageHref all are nil.
     */
    private func filterRowsArray() {
        self.rowsArray.removeAll(where: { ($0.title == nil) && ($0.description == nil) && ($0.imageHref == nil)})
    }
}
