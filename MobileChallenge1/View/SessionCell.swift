//
//  SessionCell.swift
//  MobileChallenge1
//
//  Created by Decagon on 07/06/2021.
//

import UIKit
import Kingfisher

class SessionCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var maxOutputView: UIView!
    @IBOutlet weak var exerciseName1: UILabel!
    @IBOutlet weak var practiceBpm1: UILabel!
    
    var session: Exercise?
    
    func setUp(with model: SessionResponseElement) {
        DispatchQueue.main.async {
            do
            {
                let url = URL(string: "\(constants.urlStr)\(self.session?.exerciseID ?? "")\(constants.png)")
                self.imageView?.kf.setImage(with: url)
                self.exerciseName1.text = self.session?.name
                self.practiceBpm1.text = "\(self.session?.practicedAtBPM ?? Int())"
                
            }
        }
    }
}
