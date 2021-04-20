//
//  WeatherView.swift
//  Yumemi-ios-training
//
//  Created by 坂本龍哉 on 2021/04/16.
//

import Foundation
import UIKit

class WeatherView : UIView {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadNib() {
        let nib = UINib(nibName: "WeatherView", bundle: nil)
        if let view = nib.instantiate(withOwner: self,
                                      options: nil).first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
