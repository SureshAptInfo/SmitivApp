//
//  ChildPageViewController.swift
//  SmitivApp
//
//  Created by Agility Macbook on 09/08/18.
//  Copyright © 2018 Agility Macbook. All rights reserved.
//

import UIKit
import DLRadioButton
import AIFlatSwitch
import MaterialKit
import BFPaperButton


var labelValue = "Yes"

//MARK: - UITableviewCell IBOutlets

class ChildTableViewCell: UITableViewCell{
    
    @IBOutlet var txtFirstname: UITextField!
    
    @IBOutlet var txtLastName: UITextField!
    
    @IBOutlet var txtDateOfBirth: UITextField!
    
    @IBOutlet var btnFemale: DLRadioButton!
    @IBOutlet var btnMale: DLRadioButton!
    
    
    
    @IBAction func btnActnForGenderSelection(_ sender: DLRadioButton) {
        
        let button = sender
        let index = button.tag
        
        if (index == 1) {
            btnMale.backgroundColor = UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0)
            btnMale.setTitleColor(UIColor.white, for: .normal)
            btnFemale.setTitleColor(UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0), for: .normal)
            
            btnFemale.backgroundColor = UIColor.clear
        }
        else if (index == 2) {
            btnFemale.backgroundColor = UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0)
            btnFemale.setTitleColor(UIColor.white, for: .normal)
            btnMale.setTitleColor(UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0), for: .normal)
            
            btnMale.backgroundColor  = UIColor.clear
        }
    }
    
}

class FirstTableViewCell: UITableViewCell{
    
    @IBOutlet weak var flatSwitch: AIFlatSwitch!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBAction func onSwitchValueChange(_ sender: AnyObject) {
        if sender as? AIFlatSwitch == flatSwitch {
            
            label.text = (flatSwitch.isSelected) ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: "")
            
            hintLabel.text = (flatSwitch.isSelected) ? NSLocalizedString("Plano recommends an eye test. preferably at 6 months old.", comment: "") : NSLocalizedString("Don't forget to bring your child for an eye test in 2 months and enter the results in the plano app.", comment: "")
            
            //flatSwitch.setSelected(!flatSwitch.isSelected, animated: true)
            
        }
    }
}

class SecondTableViewCell: UITableViewCell{
    @IBOutlet weak var flatSwitchTwo: AIFlatSwitch!
    @IBOutlet weak var labelTwo: UILabel!
    
    @IBAction func onSwitchValueTwoChange(_ sender: AnyObject) {
        if sender as? AIFlatSwitch == flatSwitchTwo {
            
            labelTwo.text = (flatSwitchTwo.isSelected) ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: "")
            
            //flatSwitch.setSelected(!flatSwitch.isSelected, animated: true)
            
            labelValue = labelTwo.text!
            
            print(labelValue)
        }
    }
}

class ThirdTableViewCell: UITableViewCell{
    @IBOutlet var txtYears: UITextField!
    
    @IBOutlet var txtMonths: UITextField!
    
}

class FourthTableViewCell: UITableViewCell{
    @IBOutlet var txtRightEyeOne: UITextField!
    
    @IBOutlet var txtLeftEyeOne: UITextField!
}

class FifthTableViewCell: UITableViewCell{
    @IBOutlet var txtRightEyeTwo: UITextField!
    
    @IBOutlet var txtLeftEyeTwo: UITextField!
}

class SixthTableViewCell: UITableViewCell{
    @IBOutlet var btnPrescription: UIButton!
    @IBOutlet var btnMemory: UIButton!
}

class SeventhTableViewCell: UITableViewCell{
    @IBOutlet var btnSave: UIButton!
}


class ChildPageViewController: UIViewController {

    fileprivate var stretchyHeaderViewController = StretchyHeaderViewController()
    
    //MARK: - IBOutlets
    
    @IBOutlet var tableViewChild: UITableView!
    
    var isViewDidLoad: Bool = false
    
    
    //MARK: - ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //isViewDidLoad = true
        
        tableViewChild.delegate = self
        tableViewChild.dataSource = self
        
        stretchyHeaderViewController.scrollView = tableViewChild
        
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
        
        self.present(stretchyHeaderViewController, animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        isViewDidLoad = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isViewDidLoad {
            isViewDidLoad = false
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - UITableView Delegates
extension ChildPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell:ChildTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcell") as! ChildTableViewCell
            //let cell:HeaderTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "headercell") as! HeaderTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.txtFirstname.layer.borderColor = UIColor.clear.cgColor
            cell.txtLastName.layer.borderColor = UIColor.clear.cgColor
            cell.txtDateOfBirth.layer.borderColor = UIColor.clear.cgColor
            
            cell.btnFemale.backgroundColor = .clear
            cell.btnFemale.layer.cornerRadius = 5
            cell.btnFemale.layer.borderWidth = 1
            
            cell.btnMale.backgroundColor = .clear
            cell.btnMale.layer.cornerRadius = 5
            cell.btnMale.layer.borderWidth = 1
            
            cell.btnMale.layer.borderColor = UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0).cgColor
            cell.btnFemale.layer.borderColor = UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0).cgColor
            
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = true
            
            return cell
        }
        else if indexPath.row == 1 {
            let cell:FirstTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcellone") as! FirstTableViewCell
            
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = true
            
            return cell
        }
        else if indexPath.row == 2 {
            let cell:SecondTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcelltwo") as! SecondTableViewCell
            
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = true
            
            return cell
        }
        else if indexPath.row == 3 {
            let cell:ThirdTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcellthree") as! ThirdTableViewCell
            
            cell.txtYears.layer.borderColor = UIColor.clear.cgColor
            cell.txtMonths.layer.borderColor = UIColor.clear.cgColor
            
            
            if (labelValue == "No") {
                cell.selectionStyle = .gray
                cell.isUserInteractionEnabled = false
            }
            else {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = true
            }
            return cell
        }
        else if indexPath.row == 4 {
            let cell:FourthTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcellfour") as! FourthTableViewCell
            
            
            cell.txtLeftEyeOne.leftViewMode = UITextFieldViewMode.always
            cell.txtLeftEyeOne.leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.image = UIImage(named: "LeftEye")
            cell.txtLeftEyeOne.leftView = imageView
            
            cell.txtRightEyeOne.leftViewMode = UITextFieldViewMode.always
            cell.txtRightEyeOne.leftViewMode = .always
            
            let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            
            rightImageView.image = UIImage(named: "RightEye")
            cell.txtRightEyeOne.leftView = rightImageView
            
            cell.txtLeftEyeOne.layer.borderColor = UIColor.clear.cgColor
            cell.txtRightEyeOne.layer.borderColor = UIColor.clear.cgColor
            
            if (labelValue == "No") {
                cell.selectionStyle = .gray
                cell.isUserInteractionEnabled = false
            }
            else {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = true
            }
            
            return cell
        }
        else if indexPath.row == 5 {
            let cell:FifthTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcellfive") as! FifthTableViewCell
            
            
            cell.txtLeftEyeTwo.leftViewMode = UITextFieldViewMode.always
            cell.txtLeftEyeTwo.leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.image = UIImage(named: "LeftEye")
            cell.txtLeftEyeTwo.leftView = imageView
            
            cell.txtRightEyeTwo.leftViewMode = UITextFieldViewMode.always
            cell.txtRightEyeTwo.leftViewMode = .always
            
            let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            
            rightImageView.image = UIImage(named: "RightEye")
            cell.txtRightEyeTwo.leftView = rightImageView
            
            cell.txtLeftEyeTwo.layer.borderColor = UIColor.clear.cgColor
            cell.txtRightEyeTwo.layer.borderColor = UIColor.clear.cgColor
            
            if (labelValue == "No") {
                cell.selectionStyle = .gray
                cell.isUserInteractionEnabled = false
            }
            else {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = true
            }
            
            return cell
        }
        else if indexPath.row == 6 {
            let cell:SixthTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcellsix") as! SixthTableViewCell
            
            cell.btnPrescription.backgroundColor = .clear
            cell.btnPrescription.layer.cornerRadius = 5
            cell.btnPrescription.layer.borderWidth = 1
            
            cell.btnMemory.backgroundColor = .clear
            cell.btnMemory.layer.cornerRadius = 5
            cell.btnMemory.layer.borderWidth = 1
            
            cell.btnPrescription.layer.borderColor = UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0).cgColor
            cell.btnMemory.layer.borderColor = UIColor(red: 92/255, green: 193/255, blue: 204/255, alpha: 1.0).cgColor
            
            if (labelValue == "No") {
                cell.selectionStyle = .gray
                cell.isUserInteractionEnabled = false
            }
            else {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = true
            }
            
            return cell
        }
        else if indexPath.row == 7 {
            let cell:SeventhTableViewCell = tableViewChild.dequeueReusableCell(withIdentifier: "childcellseven") as! SeventhTableViewCell
            
            if (labelValue == "No") {
                cell.selectionStyle = .gray
                cell.isUserInteractionEnabled = false
            }
            else {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = true
            }
            
            return cell
        }
        
        return UITableViewCell() //4.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if indexPath.row==0 {
            return 350
        }
        if indexPath.row==1 {
            return 340.0
        }
        if indexPath.row==3 {
            return 160.0
        }
        if indexPath.row==5 {
            return 180.0
        }
        if indexPath.row==6 {
            return 120.0
        }
        if indexPath.row==7 {
            return 100.0
        }
        
        return 200.00
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        stretchyHeaderViewController.updateHeaderView()
    }
}

