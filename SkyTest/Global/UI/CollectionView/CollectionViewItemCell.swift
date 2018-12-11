import Reusable
import UIKit

protocol CollectionContext {
    var collectionView: CollectionView { get set }
    func reload(item: Int, atSection index: Int)
}

protocol CollectionViewItemCell: Reusable where Self: UICollectionViewCell {
    var index: Int { get set }
    var section: Int { get set }
    var context: CollectionContext? { get set }
    func configureFor(index: Int, section: Int, context: CollectionContext?)
}

extension CollectionViewItemCell {
    func configureFor(index: Int, section: Int, context: CollectionContext?) {
        self.index = index
        self.section = section
        self.context = context
    }
}
