//
//  ShippingLocationVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/22/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class ShippingLocationVC: RootViewController {
    
    @IBOutlet weak var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func setupUI() {
        ClearNavigationBarAppearance(titleView: nil, title: nil)
        self.navigationItem.setHidesBackButton(true, animated:true);
        

        //Tap to exit
        let tapToClose = UITapGestureRecognizer(target: self, action: #selector(ShippingLocationVC.closeTap(_:)))
        bgView.addGestureRecognizer(tapToClose)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func insideCityButtonPressed(_ sender: Any) {
        //let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let selectWeightVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SelectWeightVC") as! SelectWeightVC
        selectWeightVC.cityType = .insideCity
        self.navigationController?.pushViewController(selectWeightVC, animated: true)
        //self.present(selectWeightVC, animated: true, completion: nil)
    }
    
    @IBAction func outsideCityButtonPressed(_ sender: Any) {
        let selectWeightVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SelectWeightVC") as! SelectWeightVC
        selectWeightVC.cityType = .outsideCity
        self.navigationController?.pushViewController(selectWeightVC, animated: true)
    }
    
    
    
    @IBAction func outsideSuadiButtonPressed(_ sender: Any) {
        let selectWeightVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SelectWeightVC") as! SelectWeightVC
        selectWeightVC.cityType = .international
        self.navigationController?.pushViewController(selectWeightVC, animated: true)
    }
    
    
    
}
