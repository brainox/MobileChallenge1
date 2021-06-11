//
//  ViewController.swift
//  MobileChallenge1
//
//  Created by Decagon on 07/06/2021.
//

import UIKit

class RootViewController: UIViewController{
    @IBOutlet weak var maxOutputLabel: UILabel!
    var session = SessionResponse()
    

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        getData()
    }
    
    func getData() {
        let url = URL(string: "http://codingtest.fretello.com:3000/data/sessions.json")
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
        return session.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "sessionCell") as! SessionCell
        cell.setUp(with: session[indexPath.row])
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.maxOutputView.layer.cornerRadius = cell.maxOutputView.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
