//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ForecastView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    
    private let cellReuseID = "ForecastCell"
    private var viewModels = [ForecastViewModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func set(with viewModels: [ForecastViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }
    
    private func commonInit() {
        let nibName = String(describing: ForecastView.self)
        Bundle.main.loadNibNamed(nibName, owner: self)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupSubviews()
    }
    
    private func setupSubviews() {
        let nibName = String(describing: ForecastCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.dataSource = self
        collectionView.register(nib, forCellWithReuseIdentifier: cellReuseID)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
    }
}


extension ForecastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? ForecastCell
        cell?.set(viewModels[indexPath.item])
        return cell ?? .init()
    }
}
