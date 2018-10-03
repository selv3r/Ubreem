//
//  SelectBankVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/21/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

protocol UserDidSelectBank {
    func getBankId(name: String, index: Int)
}

class SelectBankVC: UITableViewController {

    var banks: [Bank] = []
    var bankName: String?
    var bankId: Int?
    var selectedBankIndex: Int?
    
    var protocolType: UserDidSelectBank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        if Language.currentLanguage() == "en-US" {
            print("FUCK FUCK FUCK")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left - material"), style: .plain, target: self, action: #selector(backToLogin))
            
            closeButtonToNavigation()
        } else {
            print("SHIT SHIT SHIT")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
            closeButtonToNavigationR()
        }
        
        //self.prepareAppFont("AvenirNext")
        self.navigationItem.setHidesBackButton(true, animated: false)
        title = "Select your Bank".Localize
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return banks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BankTableViewCell", for: indexPath) as? BankTableViewCell {
            if bankName == banks[indexPath.row].englishName {
                cell.config(banks[indexPath.row], check: true)
            } else {
                cell.config(banks[indexPath.row], check: false)
            }
            return cell
            
        }
        return BankTableViewCell()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBankIndex = indexPath.row
        bankId = banks[indexPath.row].id
        bankName = banks[indexPath.row].englishName
        
        print("Selected City Id: \(bankName)")
        tableView.reloadData()
        protocolType?.getBankId(name: bankName!, index: bankId!)
        self.navigationController?.popViewController(animated: true)
        print("Table Dismissed!")
    }

}

extension SelectBankVC {
    
    
    func closeButtonToNavigation(){
        let rightAddBarButtonItemImage:UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
        self.navigationItem.setRightBarButton(rightAddBarButtonItemImage, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func closeButtonToNavigationR(){
        let rightAddBarButtonItemImage:UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
        self.navigationItem.setRightBarButton(rightAddBarButtonItemImage, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    @objc func backToLogin(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
