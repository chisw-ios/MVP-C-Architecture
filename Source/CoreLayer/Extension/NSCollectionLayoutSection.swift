//
//  NSCollectionLayoutSection.swift
//
import UIKit

extension NSCollectionLayoutSection {
    
    static func verticalLayout(
        itemsCount: Int,
        heightDimension: NSCollectionLayoutDimension = .estimated(200),
        widthDimension: NSCollectionLayoutDimension = .estimated(200),
        header: Bool = false,
        headerHeighDimension: NSCollectionLayoutDimension = .estimated(44),
        footer: Bool = false,
        footerHeighDimension: NSCollectionLayoutDimension = .estimated(44),
        reuseIdentifier: String = "",
        reuseIdentifierFooter: String = ""

    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: itemsCount)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        if header {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: headerHeighDimension
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: reuseIdentifier,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
        }
        
        if footer {
            let footerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: footerHeighDimension
            )
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: reuseIdentifierFooter,
                alignment: .bottom
            )
            section.boundarySupplementaryItems.append(sectionFooter)
        }

        return section
    }
    
    static func horizontalLayout(
        heightDimension: NSCollectionLayoutDimension = .estimated(200),
        widthDimension: NSCollectionLayoutDimension = .estimated(200),
        header: Bool = false,
        headerHeighDimension: NSCollectionLayoutDimension = .estimated(44),
        footer: Bool = false,
        footerHeighDimension: NSCollectionLayoutDimension = .estimated(44),
        scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous,
        reuseIdentifier: String = "",
        reuseIdentifierFooter: String = ""
        
    ) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollingBehavior
        
        if header {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: headerHeighDimension
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: reuseIdentifier,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
        }
        
        if footer {
            let footerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: footerHeighDimension
            )
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: reuseIdentifierFooter,
                alignment: .bottom
            )
            section.boundarySupplementaryItems.append(sectionFooter)
        }

        return section
    }
    
}
