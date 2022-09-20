//
//  NomeView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit
import Alamofire
import SwiftUI

class HomeOpenView: UIViewController {
    
    var spaceParameters: SpaceListParameters
    
    var selectedItemsArray: [String]
    
    let sessionManager = APIService()
    
    private var seletedFilterItems: [String] = []
    
    private var cells: [Space] = []
    
    private var searchCells: [Space] = []
    
    private var filterButtons = [UIButton]()
    
    private let cellIdentifier = "Cell"
    
    private let titleLabel = UILabel()
    
    private let customBar = UIView()
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var filterStackView: UIStackView = {
        
        let margins = CGFloat(10).generateSizeForScreen
        
        let view = UIStackView()
        view.setToDefaultBackgroundColor()
        view.isHidden = false
        view.spacing = 4
        view.alignment = .leading
        view.axis = .vertical
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: margins,
                                          left: margins,
                                          bottom: margins,
                                          right: margins)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        
        let margins = CGFloat(20).generateSizeForScreen
        
        let tableView = UITableView()
        tableView.setToDefaultBackgroundColor()
        tableView.register(HomeOpenTableViewCell.self,
                           forCellReuseIdentifier: cellIdentifier)
        tableView.layoutMargins = UIEdgeInsets(top: margins,
                                               left: margins,
                                               bottom: margins,
                                               right: margins)
        
        return tableView
    }()
    
    private lazy var stackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [filterStackView,
                                                       tableView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
        
        return stackView
    }()
    
    private lazy var tabBar = BravveTabBar(self,
                                           itemImagesNames: [ButtonsBravve.locationPink.rawValue,
                                                             ButtonsBravve.exitGray.rawValue
                                                            ])
    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: ImagesBravve.logoWhite.rawValue)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let coverView: UIView = {
        
        let coverView = UIView()
        coverView.backgroundColor = UIColor(red: 4/255, green: 0, blue: 94/255, alpha: 1)
        
        return coverView
    }()
    
    private lazy var leftDropDown: UIScrollView = {
        
        let leftDropDown = UIScrollView()
        leftDropDown.layer.cornerRadius = CGFloat(8).generateSizeForScreen
        leftDropDown.delegate = self
        
        return leftDropDown
    }()
    
    private lazy var rightDropDown: UIScrollView = {
        
        let rightDropDown = UIScrollView()
        rightDropDown.layer.cornerRadius = CGFloat(8).generateSizeForScreen
        rightDropDown.delegate = self
        
        return rightDropDown
    }()
    
    private lazy var homeOpenViewModel: HomeOpenViewModel = {
        
        let homeOpenViewModel = HomeOpenViewModel(customBarWithFilter, spaceParameters)
        return homeOpenViewModel
    }()
    
    private lazy var customBarWithFilter: CustomBarWithFilter = {
        
        let customBarWithFilter = customBar.setToDefaultCustomBarWithFilter() {_ in
            
            let filterView = FilterScreen(self.spaceParameters, self.selectedItemsArray)
            filterView.modalPresentationStyle = .fullScreen
            self.present(filterView, animated: true)
        }
        
        let leftHandler = {(action: UIAction) in
            
            self.rightDropDown.frame.size = .zero
            self.leftDropDown.showLikeAWindow(size: CGSize(width: self.customBarWithFilter.stackView.frame.size.width/3,
                                                           height: CGFloat(144).generateSizeForScreen),
                                              origin: CGPoint(x: self.customBarWithFilter.stackView.frame.minX + self.customBarWithFilter.stackView.frame.size.width/3,
                                                              y: self.customBarWithFilter.stackView.frame.maxY),
                                              .downLeft)
        }
        
        let rightandler = {(action: UIAction) in
            
            self.leftDropDown.frame.size = .zero
            self.rightDropDown.showLikeAWindow(size: CGSize(width: self.customBarWithFilter.stackView.frame.size.width*2/3,
                                                            height: CGFloat(144).generateSizeForScreen),
                                               origin: CGPoint(x: self.customBarWithFilter.stackView.frame.maxX,
                                                               y: self.customBarWithFilter.stackView.frame.maxY),
                                               .downLeft)
        }
        
        customBarWithFilter.leftButton.addAction(UIAction(handler: leftHandler), for: .touchUpInside)
        customBarWithFilter.rightButton.addAction(UIAction(handler: rightandler), for: .touchUpInside)
        
        return customBarWithFilter
    }()
    
    init(_ willLoad: Bool = false, _ spaceParameters: SpaceListParameters = SpaceListParameters(space_state_id: nil, space_city_id: nil, allow_workpass: nil, seats_qty: nil, space_type_id: nil, space_classification_id: nil, space_category_id: nil, space_facilities_id: nil, space_noise_level_id: nil, space_contract_Type: nil), _ selectedItemsArray: [String] = []) {
        
        imageView.isHidden = willLoad
        coverView.isHidden = willLoad
        
        self.spaceParameters = spaceParameters
        self.selectedItemsArray = selectedItemsArray
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    

    //MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seletedFilterItems = selectedItemsArray
        setupView()
        setupConstraints()
        setupDefaults()
        searchSetup()
    }
 
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationSetup()
        super.viewDidDisappear(animated)
        self.searchController.isActive = false
        tabBar.selectedItem = tabBar.items?[0]
        print("Disappear")
    }
    
    //MARK: - Search Controller Methods
    
    private func searchSetup(){
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func filterContentForSearchText(searchText: String){
        searchCells = cells.filter({ (space: Space) -> Bool in
            guard let city = space.partner_site_address?.address?.city_name else {return false}
            guard let state = space.partner_site_address?.address?.state_name else {return false}
            guard let postal = space.partner_site_address?.address?.postal_code else {return false}
            guard let address = space.partner_site_address?.address?.street else {return false}
            let cityName = city.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let stateName = state.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let postalCode = postal.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let addressName = address.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
           
            return cityName != nil || stateName != nil || postalCode != nil || addressName != nil
        })
    }
    
    //MARK: - Navigation Methods
    
    private func navigationSetup(){
        //The view that covers the statusBar
        let navigationStatusBarView = UIView()
        navigationStatusBarView.translatesAutoresizingMaskIntoConstraints = false
        navigationStatusBarView.backgroundColor = UIColor(named: "blueBravve")
        self.view.addSubview(navigationStatusBarView)
        
        NSLayoutConstraint.activate([
            navigationStatusBarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            navigationStatusBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            navigationStatusBarView.bottomAnchor.constraint(equalTo: self.stackView.topAnchor),
            navigationStatusBarView.heightAnchor.constraint(equalToConstant: 115)
        ])
        //Center View
        let logo = UIImage(named: ImagesBravve.logoWhite.rawValue)
        let centerImageView = UIImageView(image: logo)
        self.navigationItem.titleView = centerImageView
        
        //Bar Button Items Left and Right
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ButtonsBravve.search.rawValue), style: .plain, target: self, action: #selector(self.searchBarButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(self.menuBarButtonTapped))
        self.navigationController?.navigationBar.tintColor = UIColor(named: ColorsBravve.white_white.rawValue)
    }
    
    @objc func searchBarButtonTapped(){
        let searchBar: UISearchBar = self.searchController.searchBar
        searchBar.placeholder = "Busque CEP, endereço, cidade ou estado"
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.sizeToFit()
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = true
        
        let searchTextField = searchBar.searchTextField
        searchTextField.font = UIFont(name: FontsBravve.regular.rawValue, size: 15)
        searchTextField.leftView = UIView()
        searchTextField.clearButtonMode = .never
        searchTextField.backgroundColor = .white
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: ColorsBravve.buttonPink.rawValue)
        config.image = UIImage(named: ButtonsBravve.search.rawValue)
        
        DispatchQueue.main.async {
            searchTextField.rightViewMode = .always
            let searchButton = UIButton(configuration: config, primaryAction: UIAction(handler: {[weak self] action in
                self?.searchBarBookmarkButtonClicked(searchBar)
            }))
            searchButton.layer.cornerRadius = 12
            searchTextField.rightView = searchButton
            
        }
        self.navigationItem.titleView = searchBar
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.fixedSpace, primaryAction: nil, menu: nil)]
       let barButtonItem = UIBarButtonItem(image: UIImage(named: ButtonsBravve.searchFilterPink.rawValue), style: .plain, target: self, action: #selector(filterButtonTapped))
        barButtonItem.tintColor = UIColor(named: ColorsBravve.buttonPink.rawValue)
        
        self.navigationItem.rightBarButtonItem = barButtonItem
        
    }
    
    @objc func menuBarButtonTapped(){
        let logo = UIImage(named: ImagesBravve.logoWhite.rawValue)
        let centerImageView = UIImageView(image: logo)
        self.navigationItem.titleView = centerImageView
        print("menu")
    }
    
    @objc func filterButtonTapped(){
        let filterView = FilterScreen(self.spaceParameters, self.selectedItemsArray)
        self.navigationController?.pushViewController(filterView, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }

    
    //MARK: - createStackView
    private func createStackView(_ views: [UIView]) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: views)
        
        stackView.spacing = 4
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }
    
    //MARK: - setupStackView
    func setupStackView(_ buttons: [UIButton]) -> [UIStackView] {
        
        var stackViews = [UIStackView]()
        
        var from = 0
        
        if buttons.count%2 != 0 {
            
            stackViews.append(self.createStackView([buttons[from]]))
            
            from += 1
        }
        
        for i in stride(from: from,
                        to: buttons.count - 1,
                        by: 2) {
            
            stackViews.append(self.createStackView([buttons[i],
                                                    buttons[i+1]]))
        }
        
        return stackViews
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        reduceDropDowns()
    }
    
    private func setupView() {
        
        view.addSubviews([stackView, tabBar, coverView, imageView, leftDropDown, rightDropDown])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if self.seletedFilterItems.isEmpty {
            self.filterStackView.isHidden = true
        }
        
        setupSelectedButtons(filterStackView)
        
        for button in filterButtons {
            
            let handler = {(action: UIAction) in
                
                self.reduceDropDowns()
            }
            
            button.addAction(UIAction(handler: handler), for: .touchUpInside)
        }
        
        tabBar.selectedItem = tabBar.items?[0]
    }
    
    func setupSelectedButtons(_ stackView: UIStackView) {
        
        filterButtons = createCapsuleButtons(seletedFilterItems,
                                             ColorsBravve.capsuleButtonSelected)
        
        stackView.addArrangedSubviews(self.setupStackView(self.filterButtons))
    }
    
    private func setupDefaults() {
        
        view.setToDefaultBackgroundColor()
        
        homeOpenViewModel.delegate = self
        homeOpenViewModel.manageCustomBar()
    }
    
    private func setupConstraints() {
        
//        homeOpenViewModel.removeMasks(of: view)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        customBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        coverView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // scrollView.topAnchor.contraint(equalTo: self.view.contentLayoutGuide.topAchor),
        
//        homeOpenViewModel.constraint(the: stackView, to: view, by: [.leading, .trailing])
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        
        tableView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
//        homeOpenViewModel.constraint(the: tabBar, to: view.safeAreaLayoutGuide, by: [.leading, .trailing, .bottom])
        tabBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        homeOpenViewModel.constraint(the: coverView, to: view, by: [.leading, .trailing, .top, .bottom])
        coverView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coverView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        homeOpenViewModel.constraint(the: imageView, to: view.safeAreaLayoutGuide, by: [.centerX, .centerY])
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6634).isActive = true
    }
}

extension HomeOpenView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        reduceDropDowns()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive{
            return searchCells.count + 1
        }else{
            return cells.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.count > 1 {
            
            if indexPath.row == 0 {
                
                let spaceTitleCell = UITableViewCell()
                spaceTitleCell.textLabel?.setToDefault(text: "Espaços", .left)
                spaceTitleCell.textLabel?.font = UIFont(name: FontsBravve.medium.rawValue,
                                                        size: CGFloat(20).generateSizeForScreen)
                spaceTitleCell.setToDefaultBackgroundColor()
                
                return spaceTitleCell
            }
            else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeOpenTableViewCell
                cell?.delegate = self
                
                let space = (searchController.isActive) ? searchCells[indexPath.row - 1] : cells[indexPath.row - 1]
                cell?.setup(space)
                
                return cell ?? UITableViewCell()
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath)
        
        return cell
    }
}

extension HomeOpenView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        for subview in scrollView.subviews {
            
            if subview.frame.origin.x != 0 {
                
                subview.subviews[0].backgroundColor = UIColor(named: ColorsBravve.buttonPink.rawValue)
            }
        }
    }
}

extension HomeOpenView: HomeOpenTableViewCellProtocol {
    
    func chosePlace(_ id: Int?) {
        
        homeOpenViewModel.loadChosedPlace(id)
    }
    
    func loadMapView(latitude: Double?, longitude: Double?) {
        let mapView = HomeMapKitView()
        mapView.latitude = latitude
        mapView.longitude = longitude
        mapView.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(mapView, animated: true)
    }
}

extension HomeOpenView: HomeOpenViewModelProtocol {
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        navigationSetup()
    }
    
    
    func presentOtherView(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setSpaces(_ spaces: [Space]) {
        
        self.cells = spaces
        self.tableView.reloadData()
    }
    
    func setCoverView(_ alpha: CGFloat) {
        self.coverView.alpha = alpha
        self.imageView.alpha = alpha
    }
    
    func reduceDropDowns() {
        
        self.customBarWithFilter.leftButton.isSelected = false
        leftDropDown.frame.size = .zero
        rightDropDown.frame.size = .zero
    }
    
    func setupLeftDropDown(_ buttons: [UIButton]) {
        
        leftDropDown.turnIntoAList(buttons)
    }
    
    func setupRightDropDown(_ buttons: [UIButton]){
        
        rightDropDown.turnIntoAList(buttons)
    }
}

extension HomeOpenView: UISearchBarDelegate{
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HomeOpenView: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            self.filterContentForSearchText(searchText: searchText)
            self.tableView.reloadData()
        }
    }
}
