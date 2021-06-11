//
//  SessionCell.swift
//  MobileChallenge1
//
//  Created by Decagon on 07/06/2021.
//

import UIKit

class SessionCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var maxOutputView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var practiceDateLabel: UILabel!
    
    @IBOutlet weak var exerciseName1: UILabel!
    @IBOutlet weak var exerciseName2: UILabel!
    @IBOutlet weak var exerciseName3: UILabel!
    @IBOutlet weak var exerciseName4: UILabel!
    
    @IBOutlet weak var practiceBpm1: UILabel!
    @IBOutlet weak var practiceBpm2: UILabel!
    @IBOutlet weak var practiceBpm3: UILabel!
    @IBOutlet weak var practiceBpm4: UILabel!
    
    func setUp(with model: SessionResponseElement) {
        self.nameLabel.text = model.name
//        print(" Session 0: \(session[7].name)")
        self.practiceDateLabel.text = getDateFormater(date: model.practicedOnDate)
        self.exerciseName1.text = model.exercises[0].name
        self.exerciseName2.text = model.exercises[1].name
        self.exerciseName3.text = model.exercises[2].name
        self.exerciseName4.text = model.exercises[3].name
        self.practiceBpm1.text = String(model.exercises[0].practicedAtBPM)
        self.practiceBpm2.text = String(model.exercises[1].practicedAtBPM)
        self.practiceBpm3.text = String(model.exercises[2].practicedAtBPM)
        self.practiceBpm4.text = String(model.exercises[3].practicedAtBPM)
    }
}
