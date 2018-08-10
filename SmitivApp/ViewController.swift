//
//  ViewController.swift
//  SmitivApp
//
//  Created by Agility Logistics on 08/08/18.
//  Copyright © 2018 SmitivApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var stretchyHeaderViewController = StretchyHeaderViewController()
    
    fileprivate lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func ShowChildPageView() {
        
        stretchyHeaderViewController.scrollView = tableView
        
        stretchyHeaderViewController.headerTitle = "About your child"
        stretchyHeaderViewController.headerSubtitle = "Add profile image"
        stretchyHeaderViewController.image = UIImage(named: "HeaderBG")
        
        if let minHeight = NumberFormatter().number(from: "60") {
            stretchyHeaderViewController.minHeaderHeight = CGFloat(truncating: minHeight)
        } else {
            stretchyHeaderViewController.minHeaderHeight = 0.0
        }
        
        if let maxHeight = NumberFormatter().number(from: "200") {
            stretchyHeaderViewController.maxHeaderHeight = CGFloat(truncating: maxHeight)
        } else {
            stretchyHeaderViewController.maxHeaderHeight = 0.0
        }
        
        stretchyHeaderViewController.tintColor = UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0)
        
        //self.present(stretchyHeaderViewController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(stretchyHeaderViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        stretchyHeaderViewController.updateHeaderView()
    }
}
