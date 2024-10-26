//
//  View1.swift
//  TestMapBox
//
//  Created by Mina Emad on 26/10/2024.
//

import UIKit

class View1: UIView{
    
    @IBOutlet var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "View1", bundle: nil).instantiate(withOwner: self, options: nil)
        
        addSubview(view)
        view.frame = self.bounds
        
    }

}
