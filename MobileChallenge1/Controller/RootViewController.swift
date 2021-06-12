//
//  ViewController.swift
//  MobileChallenge1
//
//  Created by Decagon on 07/06/2021.
//

import UIKit
import Kingfisher

class RootViewController: UIViewController{
    @IBOutlet weak var maxOutputLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var session = SessionResponse()
    var sessionExercise: Exercise?
    
    var imageList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        getData()
    }
    
    func getData() {
        let url = URL(string: constants.url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            var json: SessionResponse?
            do {
                json = try JSONDecoder().decode(SessionResponse.self, from: data)
            } catch {
                print("Error: \(error)")
            }
            guard let result = json else {
                return
            }
            let reversed = result.reversed()
            self.session += reversed
            var exercisesArr = [[Int]]()
            for practiceSession in result {
                var exerciseBpmArr = [Int]()
                for exercise in practiceSession.exercises {
                    exerciseBpmArr.append(exercise.practicedAtBPM)
                }
                exercisesArr.append(exerciseBpmArr)
            }
            let maxO = MaxPercentBPMDifference().maxAverage(exercisesArr: exercisesArr)
            DispatchQueue.main.async {
                self.maxOutputLabel.text = "The maximum output is: \(maxO)"
                self.table.reloadData()
            }
        }.resume()
    }
}

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.session[section].exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "sessionCell") as! SessionCell
        let currentCell = session[indexPath.section].exercises[indexPath.row]
        cell.setUp(with: session[indexPath.row])
        cell.session = currentCell
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 3
        cell.maxOutputView.layer.cornerRadius = cell.maxOutputView.frame.height / 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.session.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1333333333, blue: 0.1294117647, alpha: 1)
        let sessionHeaderLabel = UILabel()
        sessionHeaderLabel.text = (session[section].name).uppercased()
        sessionHeaderLabel.textColor =  #colorLiteral(red: 0.9333333333, green: 0.768627451, blue: 0.462745098, alpha: 1)
        sessionHeaderLabel.font = UIFont(name: constants.fontBold, size: 18)
        sessionHeaderLabel.frame = CGRect(x: 20, y: -10 , width: self.view.frame.width, height: 50)
        sectionHeader.addSubview(sessionHeaderLabel)
        
        let exerciseLabel = UILabel()
        exerciseLabel.text = String((session[section].practicedOnDate).prefix(10) )
        exerciseLabel.textColor =  #colorLiteral(red: 0.9333333333, green: 0.768627451, blue: 0.462745098, alpha: 1)
        exerciseLabel.font = UIFont(name: constants.fontRegular, size: 13)
        exerciseLabel.frame = CGRect(x: 20, y: 15 , width: self.view.frame.width, height: 50)
        sectionHeader.addSubview(exerciseLabel)
        return sectionHeader
    }
}
