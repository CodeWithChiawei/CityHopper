
import UIKit
import Foundation


class ContinentGlobeView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ContinentGlobeCollectionCell.self, forCellWithReuseIdentifier: ContinentGlobeCollectionCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    let globeView: ContinentGlobe_GlobeView = {
        let globeView = ContinentGlobe_GlobeView()
        globeView.translatesAutoresizingMaskIntoConstraints = false
        globeView.clipsToBounds = true
        return globeView
    }()
    
    let exploreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .cyan.withAlphaComponent(0.8)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Explore", for: .normal)
        button.layer.cornerRadius = 15
        button.addShadow()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(globeView)
        addSubview(collectionView)
        addSubview(exploreButton)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        collectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        
        globeView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        globeView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        globeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        globeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        exploreButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -40).isActive = true
        exploreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        exploreButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        exploreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 85).isActive = true
        exploreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -85).isActive = true
    }
    
}

extension UIButton {
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        clipsToBounds = false
    }
}
