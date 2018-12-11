import UIKit

class CollectionView: UICollectionView {
    private let collectionViewFlow: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        return layout
    }()

    init() {
        super.init(frame: .zero, collectionViewLayout: collectionViewFlow)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
