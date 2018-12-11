import UIKit

protocol CollectionAdatperDataSource {
    func viewForEmptyState() -> UIView?
}

class CollectionSectionAdapter: NSObject, CollectionContext {
    var collectionView: CollectionView
    var sections: [CollectionViewSection]
    
    var adapterDataSource: CollectionAdatperDataSource? {
        didSet {
            updateBackgroundView(shouldShowEmptyView: isItemCountZero())
        }
    }
    
    private var sectionDataSource: CollectionViewSectionDataSource?
    
    init(sections: [CollectionViewSection], collectionView: CollectionView, adapterDataSource: CollectionAdatperDataSource? = nil) {
        self.sections = sections
        self.adapterDataSource = adapterDataSource
        self.collectionView = collectionView
        super.init()
        sectionDataSource = CollectionViewSectionDataSource(collectionViewSections: sections, context: self)
        updateBackgroundView(shouldShowEmptyView: isItemCountZero())
    }
    
    func insert(section: CollectionViewSection) {
        sections.append(section)
        sectionDataSource?.collectionViewSections = sections
        collectionView.insertSections(IndexSet(integer: sections.count - 1))
        updateBackgroundView(shouldShowEmptyView: isItemCountZero())
    }
    
    func insert(item: CollectionViewItem, atSection index: Int) {
        var sectionItem = self.sections[index]
        sectionItem.collectionViewItems.append(item)
        sectionDataSource?.collectionViewSections = sections
        let indexPath = IndexPath(row: sectionItem.collectionViewItems.count - 1, section: index)
        collectionView.insertItems(at: [indexPath])
        updateBackgroundView(shouldShowEmptyView: isItemCountZero())
    }
    
    func delete(item: Int, atSection index: Int) {
        var sectionItem = self.sections[index]
        if sectionItem.collectionViewItems[item] != nil {
            sectionItem.collectionViewItems.remove(at: item)
            sectionDataSource?.collectionViewSections = sections
            let indexPath = IndexPath(row: item, section: index)
            collectionView.deleteItems(at: [indexPath])
            updateBackgroundView(shouldShowEmptyView: isItemCountZero())
        }
    }
    
    fileprivate func isItemCountZero() -> Bool {
        var isZero = true
        for value in sections where value.collectionViewItems.count > 0 {
            isZero = false
            break
        }
        
        return isZero
    }
    
    fileprivate func updateBackgroundView(shouldShowEmptyView: Bool) {
        if shouldShowEmptyView {
            collectionView.backgroundView = adapterDataSource?.viewForEmptyState()
        } else {
            collectionView.backgroundView = nil
        }
    }
    
    func reload(item: Int, atSection index: Int) {
        var sectionItem = self.sections[index]
        if sectionItem.collectionViewItems[item] != nil {
            let indexPath = IndexPath(row: item, section: index)
            
            UIView.performWithoutAnimation {
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
}
