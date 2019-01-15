//
//  DynamicCellSize.swift
//  ImgaeListApp
//
//  Created by test on 15/01/19.
//  Copyright © 2019 Pavan Shisode. All rights reserved.
//

import Foundation

import UIKit

public protocol ContentDynamicLayoutDelegate: class {
    func cellSize(indexPath: IndexPath) -> CGSize
}

public struct ItemsPadding {
    public let horizontal: CGFloat
    public let vertical: CGFloat
    
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    static var zero: ItemsPadding {
        return ItemsPadding()
    }
}

public class ContentDynamicLayout: UICollectionViewFlowLayout {
    public private(set) var cachedLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    public var contentPadding: ItemsPadding = .zero
    public var cellsPadding: ItemsPadding = .zero
    public var contentSize: CGSize = .zero
    public weak var delegate: ContentDynamicLayoutDelegate?
    
    override public func prepare() {
        super.prepare()
        
        cachedLayoutAttributes.removeAll()
        calculateCellFrames()
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cachedLayoutAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedLayoutAttributes.first { attributes -> Bool in
            return attributes.indexPath == indexPath
        }
    }
    
    public func calculateCellFrames() {
        fatalError("Method must be overriden")
    }
    
    func addCachedLayoutAttributes(attributes: UICollectionViewLayoutAttributes) {
        cachedLayoutAttributes.append(attributes)
    }
    
    override public var collectionViewContentSize: CGSize {
        return contentSize
    }
}

public class PinterestStyleFlowLayout: ContentDynamicLayout {
    private var previousCellsYOffset = [CGFloat]()
    
    public var columnsCount: Int = 1
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom

    override public func calculateCellFrames() {
        guard let contentCollectionView = collectionView, delegate != nil else {
            return
        }
    
        switch deviceIdiom {
        case .pad:
            columnsCount = 3
        default:
            columnsCount = 1
        }
        
        contentSize.width = contentCollectionView.frame.size.width
        
        var currentColumnIndex: Int = 0
        
        previousCellsYOffset = [CGFloat](repeating: contentPadding.vertical, count: columnsCount)
        
        let sectionsCount = contentCollectionView.numberOfSections
        
        for section in 0..<sectionsCount {
            for item in 0 ..< contentCollectionView.numberOfItems(inSection: section) {
                let cellWidth = calculateCellWidth()
                
                let indexPath = IndexPath(item: item, section: section)
                
                let cellSize = delegate!.cellSize(indexPath: indexPath)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame.size = delegate!.cellSize(indexPath: indexPath)
                attributes.frame.size.width = cellWidth
                
                let minOffsetInfo = minYOffsetFrom(array: previousCellsYOffset)
                attributes.frame.origin.y = minOffsetInfo.offset
                
                currentColumnIndex = minOffsetInfo.index
                
                attributes.frame.origin.x = CGFloat(currentColumnIndex) * (cellWidth + cellsPadding.horizontal) + contentPadding.horizontal
                
                previousCellsYOffset[currentColumnIndex] = cellSize.height + previousCellsYOffset[currentColumnIndex] + cellsPadding.vertical
                
                addCachedLayoutAttributes(attributes: attributes)
            }
        }
        
        contentSize.height = previousCellsYOffset.max()! + contentPadding.vertical - cellsPadding.vertical
    }
    
    private func minYOffsetFrom(array: [CGFloat]) -> (offset: CGFloat, index: Int) {
        let minYOffset = array.min()!
        let minIndex = array.index(of: minYOffset)!
        
        return (minYOffset, minIndex)
    }
    
    private func calculateCellWidth() -> CGFloat {
        let collectionViewWidth = collectionView!.frame.size.width
        let innerCellsPading = CGFloat(columnsCount - 1) * cellsPadding.horizontal
        let contentWidth = collectionViewWidth - 2 * contentPadding.horizontal - innerCellsPading
        
        return contentWidth / CGFloat(columnsCount)
    }
}

class CellSizeProvider {
    
    class func provideSizes(items: [Rows]) -> [CGSize] {
        var cellSizes = [CGSize]()
        var size: CGSize = .zero
        
        for item in items {
            size = CellSizeProvider.provideCellSize(item: item.description ?? "")
            cellSizes.append(size)
        }
        
        return cellSizes
    }
    
    private class func provideCellSize(item: String) -> CGSize {
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        var extraHeight: CGFloat = 150
        
        switch deviceIdiom {
        case .pad:
            extraHeight = 150
        default:
            extraHeight = 100
        }
        
        let height = item.height(withConstrainedWidth: 300, font: .systemFont(ofSize: 17)) + CGFloat(50)
        return CGSize(width: 00, height: height + extraHeight)
    }
}
