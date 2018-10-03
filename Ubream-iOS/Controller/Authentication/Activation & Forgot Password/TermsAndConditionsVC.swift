//
//  TermsAndConditionsVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 10/1/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Terms And Conditions"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else {
            return tableView.frame.size.height - 150
        }
    }

}
