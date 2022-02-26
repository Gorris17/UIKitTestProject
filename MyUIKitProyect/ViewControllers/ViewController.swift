//
//  ViewController.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import UIKit

class ViewController: UIViewController, CategoryCellProtocol {
    
    
    
    //MARK: - Properties
    let viewModel = BusinessViewModel()
    let categories: [BusinessCategory] = [.shopping,.beauty,.food,.leisure]

    
    //MARK: - Outlets
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var businessTable: UITableView!
    
    @IBOutlet weak var totalBusinessOuterView: UIView!
    @IBOutlet weak var closedBusinessOuterView: UIView!
    @IBOutlet weak var totalBusinessFilterView: UIView!
    @IBOutlet weak var closedBusinessFilterView: UIView!
    @IBOutlet weak var totalBusinessNumberLabel: UILabel!
    @IBOutlet weak var totalBusinessDescLabel: UILabel!
    @IBOutlet weak var closedBusinessNumberLabel: UILabel!
    @IBOutlet weak var closedBusinessDescLabel: UILabel!
    
    //MARK: - Actions
    
    @IBAction func totalBusinessFilterSelected(_ sender: Any) {
        viewModel.allBusinessFilterSelected(completion: {
            self.businessTable.reloadData()
            self.categoryCollection.reloadData()
            self.updateFilters()
        })
    }
    
    @IBAction func closedBusinessFilterSelected(_ sender: Any) {
        viewModel.closedBusinessFilterSelected(completion: {
            self.businessTable.reloadData()
            self.categoryCollection.reloadData()
            self.updateFilters()
        })
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure table and collection
        categoryCollection.register(UINib.init(nibName: "CategoryCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        businessTable.register(UINib.init(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "businessCell")
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        businessTable.dataSource = self
        businessTable.delegate = self
        businessTable.showsVerticalScrollIndicator = false
        businessTable.separatorColor = .clear
        
        //Setup view
        self.title = "Listado de Comercios"
        setFiltersViews()
        //Load data
        viewModel.loadBusiness(completion: {
            self.businessTable.reloadData()
            self.totalBusinessNumberLabel.text = "\(self.viewModel.totalBusinessList.count)"
            self.closedBusinessNumberLabel.text = "\(self.viewModel.closedBusinessNumber)"
        })
    }
    
    private func setFiltersViews() {
        totalBusinessOuterView.backgroundColor = UIColor.clear
        totalBusinessOuterView.layer.shadowColor = UIColor.gray.cgColor
        totalBusinessOuterView.layer.shadowOffset = CGSize(width: 2, height: 2)
        totalBusinessOuterView.layer.shadowOpacity = 0.75
        totalBusinessOuterView.layer.shadowRadius = 5
        totalBusinessFilterView.layer.cornerRadius = 5
        totalBusinessFilterView.layer.borderWidth = 0
        totalBusinessFilterView.layer.masksToBounds = true

        closedBusinessOuterView.backgroundColor = UIColor.clear
        closedBusinessOuterView.layer.shadowColor = UIColor.gray.cgColor
        closedBusinessOuterView.layer.shadowOffset = CGSize(width: 2, height: 2)
        closedBusinessOuterView.layer.shadowOpacity = 0.75
        closedBusinessOuterView.layer.shadowRadius = 5
        closedBusinessFilterView.layer.cornerRadius = 5
        closedBusinessFilterView.layer.borderWidth = 0
        closedBusinessFilterView.layer.masksToBounds = true
        
        updateFilters()
    }
    
    
    //MARK: - Private methods
    private func updateFilters() {
        totalBusinessFilterView.backgroundColor = viewModel.totalBusinessSelected ? .blue : .white
        totalBusinessNumberLabel.textColor = viewModel.totalBusinessSelected ? .white : .orange
        totalBusinessDescLabel.textColor = viewModel.totalBusinessSelected ? .white : .black

        closedBusinessFilterView.backgroundColor = viewModel.closedBusinessSelected ? .blue : .white
        closedBusinessNumberLabel.textColor = viewModel.closedBusinessSelected ? .white : .orange
        closedBusinessDescLabel.textColor = viewModel.closedBusinessSelected ? .white : .black
    }

    //MARK: - CategoryCellProtocol
    func categorySelected(type: BusinessCategory) {
        viewModel.selectCategory(category: type) {
            self.businessTable.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.businessList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = businessTable.dequeueReusableCell(withIdentifier: "businessCell") as? BusinessTableViewCell {
            let business = viewModel.businessList[indexPath.row]
            cell.configureCell(business: business)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(identifier: "businessDetailId") as? BusinessDetailViewController {
            detailVC.business = viewModel.businessList[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCellCollectionViewCell {
            let category = categories[indexPath.row]
            cell.configureCell(type: category, selected: viewModel.categorySelected.contains(category))
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
