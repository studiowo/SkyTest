import UIKit

class CollectionViewSectionDataSource: NSObject {
    var collectionViewSections: [CollectionViewSection] {
        didSet {
            registerCells(collectionView: context.collectionView)
        }
    }

    var context: CollectionContext
    var adapterDataSource: CollectionAdatperDataSource?

    init(collectionViewSections: [CollectionViewSection], context: CollectionContext) {
        self.collectionViewSections = collectionViewSections
        self.context = context
        super.init()
        registerCells(collectionView: context.collectionView)
        context.collectionView.delegate = self
        context.collectionView.dataSource = self
    }

    private func registerCells(collectionView: UICollectionView) {
        collectionViewSections.forEach { section in
            section.collectionViewItems.forEach { row in
                row.registerFor(collectionView: collectionView)
            }
        }
    }
}

extension CollectionViewSectionDataSource: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return collectionViewSections.count
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewSections[section].collectionViewItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellRow = collectionViewSections[indexPath.section].collectionViewItems[indexPath.row].dequeue(collectionView: collectionView,
                                                                                                           indexPath: indexPath)
        cellRow.configureFor(index: indexPath.row, section: indexPath.section, context: context)

        debugPrint(cellRow)

        guard let cell = cellRow as? UICollectionViewCell else {
            fatalError("The form cell \(cellRow) must be a UICollectionView")
        }

        return cell
    }
}

extension CollectionViewSectionDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = collectionViewSections[section]

        return section.padding
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let section = collectionViewSections[section]

        return section.distanceBetweenItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = collectionViewSections[indexPath.section]
        let row = section.collectionViewItems[indexPath.row]

        let insets = section.padding
        let width = collectionView.frame.width - (insets.right + insets.left)

        return CGSize(width: width, height: row.heightForItem)
    }
}
