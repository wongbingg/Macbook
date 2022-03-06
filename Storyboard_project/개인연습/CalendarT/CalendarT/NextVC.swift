//
//  NextVC.swift
//  CalendarT
//
//  Created by 이원빈 on 2022/02/22.
//

import UIKit
import Kingfisher

class NextVC: UIViewController {

    @IBOutlet weak var leaguenameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leaguelogoImage: UIImageView!
    
    @IBOutlet weak var homeLogoImage: UIImageView!
    @IBOutlet weak var homeTeam: UILabel!
    
    @IBOutlet weak var awayLogoImage: UIImageView!
    @IBOutlet weak var awayTeam: UILabel!
    
    var sportManager = SportManager()

    var currentDate: String? // viewcontroller 에서 받아온 date 값
    var currentTeamId: String? // viewcontroller 에서 받아온 teamId 값
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sportManager.delegate = self
        sportManager.getData(season: "2021", teamid: currentTeamId!, date: currentDate!)
        
    }
}

extension NextVC: SportManagerDelegate {
    
    
    func didUpdateSport(_ sportManager: SportManager, sport: SportModel) {
        let url = URL(string: sport.logoimagestring)
        let url1 = URL(string: sport.homeLogo)
        let url2 = URL(string: sport.awayLogo)

        DispatchQueue.main.async {
            
            self.leaguelogoImage.kf.setImage(with:url)
            self.leaguenameLabel.text = sport.leagueName
            self.homeLogoImage.kf.setImage(with:url1)
            self.homeTeam.text = "\(sport.homeTeam)"
            self.awayLogoImage.kf.setImage(with:url2)
            self.awayTeam.text = sport.awayTeam
            
            self.dateLabel.text = "Date: \(sport.date)"
           
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
