import UIKit

class CollectionViewSelfSizingItemCell: UICollectionViewCell, CollectionViewItemCell {
    var index: Int
    var section: Int
    var context: CollectionContext?

    override init(frame: CGRect) {
        index = -1
        section = -1
        super.init(frame: frame)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        superview?.setNeedsLayout()
        superview?.layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
