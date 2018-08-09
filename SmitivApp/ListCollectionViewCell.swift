//
//  ListCollectionViewCell.swift
//  RecipesApp
//
//  Created by Daniel Arantes Loverde on 5/9/17.
//  Copyright © 2017 Loverde Co. All rights reserved.
//

import UIKit
import AIFlatSwitch
import MaterialKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flatSwitch: AIFlatSwitch!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var hintlabel: UILabel!
    
    @IBOutlet weak var TxtFirstName: MKTextField!
    @IBOutlet weak var TxtLastName: MKTextField!
    @IBOutlet weak var TxtDateOfBirth: MKTextField!
    
    
    override init(frame: CGRect) {
        
        
        
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    @IBAction func onSwitchValueChange(_ sender: AnyObject) {
        if sender as? AIFlatSwitch == flatSwitch {
            self.updateSwitchValue()
            
            //flatSwitch.setSelected(!flatSwitch.isSelected, animated: true)
            
        }
    }
    
    func updateSwitchValue() {
        label.text = (flatSwitch.isSelected) ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: "")
    }
}
