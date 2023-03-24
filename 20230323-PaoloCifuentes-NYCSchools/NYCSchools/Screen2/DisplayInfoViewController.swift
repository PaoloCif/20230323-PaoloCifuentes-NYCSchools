//
//  DisplayInfoViewController.swift
//  NYCSchools
//
//  Created by Paolo Cifuentes on 03/21/23.
//

import UIKit

//Second Screen to display details of schools
class DisplayInfoViewController: UIViewController {
    
    @IBOutlet private weak var schoolName: UILabel!
    @IBOutlet private weak var criticalScore: UILabel!
    @IBOutlet private weak var mathScore: UILabel!
    @IBOutlet private weak var writingScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let school = school else { return }
        schoolName.text = school.schoolName
        criticalScore.text = "SAT Critical Thinking Avg Score: \(school.satCriticalReading)"
        mathScore.text = "SAT Math Avg Score: \(school.satMath)"
        writingScore.text = "SAT Writing Avg Score: \(school.satWriting)"
        
    }
    var school: School?
    
    
}
