//
//  ViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()

    private let appNameImageView = UIImageView()
    private var filterView: UICollectionView!
    private var listingView: UICollectionView!
    
    private var filters: [Filter] = [Filter(name: "Beauty"), Filter(name: "Fashion"), Filter(name: "Media"), Filter(name: "Tech"), Filter(name: "Crafts"), Filter(name: "Food"), Filter(name: "Other")]
    private var filtersSelected: [Filter] = []
    
    private var allListings: [Listing] = []
    private var listingsSelected: [Listing] = []
    
    private let listingCellReuseID = "listingCellReuseID"
    private let filterCellReuseID = "filterCellReuseID"
    
    private let cellPadding: CGFloat = 10
    private let sectionPadding: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        getAllListings()
        
        filterData()
        
        setUpUIComponents()
        
        setUpConstraints()
    }
    
    func getAllListings () {
        NetworkManager.getAllListings() { listing in
            self.allListings = listing
            self.listingsSelected = listing
            self.listingView.reloadData()
        }
    }
    
    func setUpUIComponents() {
        appNameImageView.image = UIImage(named: "circus")
        appNameImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appNameImageView)
                
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.sectionInset = UIEdgeInsets(top: 0, left: sectionPadding, bottom: 0, right: sectionPadding)
        
        filterView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        filterView.backgroundColor = .clear
        filterView.showsHorizontalScrollIndicator = false
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
        filterView.register(FilterCell.self, forCellWithReuseIdentifier: filterCellReuseID)
        
        filterView.dataSource = self
        filterView.delegate = self
        
        view.addSubview(filterView)
        
        
        let listingLayout = UICollectionViewFlowLayout()
        listingLayout.scrollDirection = .vertical
        listingLayout.minimumLineSpacing = cellPadding
        listingLayout.minimumInteritemSpacing = cellPadding
        listingLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        
        listingView = UICollectionView(frame: .zero, collectionViewLayout: listingLayout)
        listingView.backgroundColor = .clear
        listingView.translatesAutoresizingMaskIntoConstraints = false
        listingView.showsVerticalScrollIndicator = false
        listingView.alwaysBounceVertical = true
        
        listingView.register(ListingCell.self, forCellWithReuseIdentifier: listingCellReuseID)
        
        listingView.dataSource = self
        listingView.delegate = self
        
        view.addSubview(listingView)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        listingView.addSubview(refreshControl)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            appNameImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appNameImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25)
        ])
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: appNameImageView.bottomAnchor, constant: 12),
            filterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            listingView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            listingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            listingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            listingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    func filterData() {
        listingsSelected.removeAll()
        if filtersSelected.count == 0 {
            listingsSelected = allListings
        }
        else {
            for listing in allListings {
                if selectedByFilter(listing: listing) {
                    listingsSelected.append(listing)
                }
            }
        }
    }
    
    func selectedByFilter (listing: Listing) -> Bool {
        for filter in filtersSelected {
            if listing.category == filter.name {
                return true
            }
        }
        return false
    }
    
    @objc private func refresh(_ sender: AnyObject) {
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            self.listingView.reloadData()
//            self.refreshControl.endRefreshing()
//        }
        listingView.reloadData()
        refreshControl.endRefreshing()
    }

}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listingView {
            let cell = listingView.dequeueReusableCell(withReuseIdentifier: listingCellReuseID, for: indexPath) as! ListingCell
            let listing = listingsSelected[indexPath.item]
            cell.configure(for: listing)
            cell.layer.shadowColor = .lightBlue
            cell.layer.shadowOffset = CGSize(width: 2, height: 4)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 0.3
            cell.layer.masksToBounds = false
            return cell
        }
        else {
            let cell = filterView.dequeueReusableCell(withReuseIdentifier: filterCellReuseID, for: indexPath) as! FilterCell
            let filter = filters[indexPath.item]
            cell.configure(for: filter)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == listingView {
            return listingsSelected.count
        }
        else {
            return filters.count
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == listingView {
            let size = (listingView.frame.width - cellPadding)/2 - sectionPadding
            return CGSize(width: size-5, height: 200)
        }
        else {
            return CGSize(width: 80, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == listingView {
            return cellPadding+10
        }
        else {
            return cellPadding-2
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == listingView {
            let listing = allListings[indexPath.item]
            let view = ListingViewController(listing: listing)
            navigationController?.pushViewController(view, animated: true)
        }
        if collectionView == filterView {
            let filter = filters[indexPath.item]
            
            if filter.isSelected == false {
                filter.isSelected = true
                filtersSelected.append(filter)
            }
            else {
                filter.isSelected = false
                filtersSelected.removeAll { f in
                    return f == filter
                }
            }
            
            filterData()
            
            let cell = filterView.dequeueReusableCell(withReuseIdentifier: filterCellReuseID, for: indexPath) as! FilterCell
            cell.didSelect.toggle()
            
        }
        filterView.reloadData()
        listingView.reloadData()
    }
    
}
