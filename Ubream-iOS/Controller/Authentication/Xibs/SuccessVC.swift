//
//  SuccessVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/20/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class SuccessVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonPressed(_ sender: Any) {
        let loginViewController = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "MainLoginVC") as! MainLoginVC
        self.present(loginViewController, animated: true, completion: nil)
    }
    
}
