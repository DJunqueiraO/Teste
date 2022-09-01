//
//  HomeFechadaView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit

class HomeClosedView: UIViewController {
    
    var spaceParameters: SpaceListParameters
    
    var selectedItemsArray: [String]
    
    let sessionManager = SessionManager()
    
    private var seletedFilterItems: [String] = []
    
    private var cells: [Space] = []
    
    private var filterButtons = [UIButton]()
    
    private let cellIdentifier = "Cell"
    
    private let titleLabel = UILabel()
    
    private let customBar = UIView()
    
    private lazy var filterStackView: UIStackView = {
        
        let margins = CGFloat(10).generateSizeForScreen
        
        let stackView = UIStackView()
        stackView.setToDefaultBackgroundColor()
        stackView.isHidden = false
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: margins,
                                               left: margins,
                                               bottom: margins,
                                               right: margins)
        
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        
        let margins = CGFloat(20).generateSizeForScreen
        
        let tableView = UITableView()
        tableView.setToDefaultBackgroundColor()
        tableView.register(HomeClosedTableViewCell.self,
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
        stackView.isHidden = false
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
        
        return stackView
    }()
    
    private lazy var tabBar = TabBarClosed.init(self)
    
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
    
    private lazy var homeClosedViewModel: HomeClosedViewModel = {
        
        let homeClosedViewModel = HomeClosedViewModel(customBarWithFilter, spaceParameters)
        return homeClosedViewModel
    }()
    
    private lazy var customBarWithFilter: CustomBarWithFilter = {
        
        let customBarWithFilter = customBar.setToDefaultCustomBarWithFilter() {_ in
            
            let filterView = FilterViewClosed(self.spaceParameters, self.selectedItemsArray)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        tabBar.selectedItem = tabBar.items?[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seletedFilterItems = selectedItemsArray
        print("kaue \(spaceParameters.space_category_id)")
        print("kaue \(spaceParameters.space_type_id)")
        print("kaue \(spaceParameters.space_facilities_id)")
        print("kaue \(spaceParameters.space_contract_Type)")
        print("kaue \(spaceParameters.space_classification_id)")
        print("kaue \(spaceParameters.space_noise_level_id)")
        print("kaue \(spaceParameters.seats_qty)")
        print("kaue \(seletedFilterItems)")
        setupView()
        setupConstraints()
        setupDefaults()
    }
    
    private func createStackView(_ views: [UIView]) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: views)
        
            stackView.spacing = 4
            stackView.backgroundColor = .white
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
        
        return stackView
    }
    
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

        view.addSubviews([stackView, customBar, tabBar, coverView, imageView, leftDropDown, rightDropDown])
        
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
        
        homeClosedViewModel.delegate = self
        homeClosedViewModel.manageCustomBar()
    }
    
    private func setupConstraints() {
        
        stackView.constraintOutsideTo(.top, customBar)
        stackView.constraintInsideTo(.leading, view.safeAreaLayoutGuide)
        stackView.constraintInsideTo(.trailing, view.safeAreaLayoutGuide)
        stackView.constraintOutsideTo(.bottom, tabBar)
        
        tableView.widthAnchorInSuperview(view.frame.size.width)
        
        tabBar.constraintInsideTo(.leading, view.safeAreaLayoutGuide)
        tabBar.constraintInsideTo(.trailing, view.safeAreaLayoutGuide)
        tabBar.constraintInsideTo(.bottom, view.safeAreaLayoutGuide)
        
        coverView.constraintInsideTo(.top, view)
        coverView.constraintInsideTo(.leading, view.safeAreaLayoutGuide)
        coverView.constraintInsideTo(.trailing, view.safeAreaLayoutGuide)
        coverView.constraintInsideTo(.bottom, view)
        
        imageView.constraintInsideTo(.centerX, view.safeAreaLayoutGuide)
        imageView.constraintInsideTo(.centerY, view.safeAreaLayoutGuide)
        imageView.constraintInsideTo(.height, view.safeAreaLayoutGuide, multiplier: 0.08)
        imageView.constraintInsideTo(.width, view.safeAreaLayoutGuide, multiplier: 0.6634)
    }
}

extension HomeClosedView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        reduceDropDowns()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count + 1
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeClosedTableViewCell
                cell?.delegate = self

                cell?.setup(cells[indexPath.row - 1], IndexPath(row: indexPath.row - 1,
                                                                section: indexPath.section - 1))
                
                return cell ?? UITableViewCell()
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath)
        
        return cell
    }
}

extension HomeClosedView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        for subview in scrollView.subviews {
            if subview.frame.origin.x != 0 {
                subview.subviews[0].backgroundColor = UIColor(named: ColorsBravve.buttonPink.rawValue)
            }
        }
    }
}


extension HomeClosedView: HomeClosedTableViewCellProtocol {
    
    func chosePlace(_ indexPath: IndexPath) {
        guard let spaceId = cells[indexPath.row].id else { return }
        
        sessionManager.getOpenData(id: "\(spaceId)", endpoint: .spacesId) { (statusCode, error, space: SpaceDetail?) in
            guard let space = space else {
                print(statusCode as Any)
                print(error?.localizedDescription as Any)
                return
            }
            let detailsClosedView = DetailsClosedView(space, spaceId: spaceId)
            detailsClosedView.modalPresentationStyle = .fullScreen
            self.present(detailsClosedView, animated: false)
        }
    }
}

extension HomeClosedView: HomeClosedViewModelProtocol {
    
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
