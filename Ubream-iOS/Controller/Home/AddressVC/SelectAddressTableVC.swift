//
//  SelectAddressTableVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

enum LocationType {
    case pickup
    case destination
}

protocol UserDidSelectShippingAddressProtocol {
    func getaddressId(addressHeader: String, id: Int)
    func getDestinationAddressId(destinationAddress: String, destinationId: Int, recipientPhone: String)
}

class SelectAddressTableVC: RootViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var addresses: [Address] = []
    var delegate: UserDidSelectShippingAddressProtocol?
    var locationType: LocationType?
    var addressHeader: String?
    var addressId: Int?
    var selectedIndex: Int?
    var addressPhone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = true
////        self.navigationController?.navigationItem.rightBarButtonItem.is
//        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add_circle - material"), style: .plain, target: self, action: #selector(addTapped))
//        self.navigationItem.rightBarButtonItem = addButton
    
        let nib = UINib(nibName: "AddressTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AddressTableViewCell")
    }
    
    func setupUI() {
        if locationType == .pickup {
            title = "Shipment Pickup"
            loadPickupData()
        } else if locationType == .destination {
            title = "Shipment Destination"
            loadDestinationData()
        }
    }
    
    
    @IBAction func addBarButtonPressed(_ sender: Any) {
        if locationType == .pickup {
            let addVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AddNewAddressVC") as! AddNewAddressVC
            addVC.locationType = .pickup
            self.navigationController?.pushViewController(addVC, animated: true)
        } else if locationType == .destination {
            let addVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AddNewAddressVC") as! AddNewAddressVC
            addVC.locationType = .destination
            self.navigationController?.pushViewController(addVC, animated: true)
    }
    
//    @objc func addTapped() {
//        if locationType == .pickup {
//            let addVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AddNewAddressVC") as! AddNewAddressVC
//            addVC.locationType = .pickup
//            self.navigationController?.pushViewController(addVC, animated: true)
//        } else if locationType == .destination {
//            let addVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AddNewAddressVC") as! AddNewAddressVC
//            addVC.locationType = .destination
//            self.navigationController?.pushViewController(addVC, animated: true)
//        }
        
        //present(addVC, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if locationType == .pickup {
            loadPickupData()
        } else if locationType == .destination {
            loadDestinationData()
        }
        tableView.reloadData()
    }
    
    
    func loadDestinationData() {
        self.addresses = []
        StartLoading()
        API.shared.getDestinationAddresses(apiToken: (SavedUser.loadUser()?.apiToken)!) { (data, success, error) in
            if let error = error {
                self.StopLoading()
                print(error)
            }
            if let allAddresses = data {
                self.StopLoading()
                self.addresses = allAddresses
                self.tableView.reloadData()
            }
        }
    }
    
    func loadPickupData() {
        self.addresses = []
        StartLoading()
        API.shared.getPickUpAddresses(apiToken: (SavedUser.loadUser()?.apiToken)!) { (data, success, error) in
            if let error = error {
                self.StopLoading()
                print(error)
            }
            if let allAddresses = data {
                self.StopLoading()
                self.addresses = allAddresses
                self.tableView.reloadData()
            }
        }
    }
}

extension SelectAddressTableVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as? AddressTableViewCell {
            if addressId == addresses[indexPath.row].id {
                cell.config(addresses[indexPath.row], check: true)
            } else {
                cell.config(addresses[indexPath.row], check: false)
            }
            return cell
        }
        return AddressTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressHeader = addresses[indexPath.row].name
        addressId = addresses[indexPath.row].id
        addressPhone = addresses[indexPath.row].phone
        if locationType == .pickup {
            delegate?.getaddressId(addressHeader: addressHeader!, id: addressId!)
        } else if locationType == .destination {
            delegate?.getDestinationAddressId(destinationAddress: addressHeader!, destinationId: addressId!, recipientPhone: addressPhone!)
        }
        tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
