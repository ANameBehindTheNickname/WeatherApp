//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ForecastCell: UICollectionViewCell {
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!
    
    private let cellReuseID = "HourlyCell"
    private var hourlyWeatherViewModels = [ForecastViewModel.HourlyWeatherViewModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nibName = String(describing: HourlyCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(110))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layoutSection)
    }
    
    func set(_ viewModel: ForecastViewModel) {
        dayLabel.text = viewModel.day
        hourlyWeatherViewModels = viewModel.hourlyWeatherViewModels
    }
}

extension ForecastCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyWeatherViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? HourlyCell
        cell?.set(hourlyWeatherViewModels[indexPath.item])
        return cell ?? .init()
    }
}
