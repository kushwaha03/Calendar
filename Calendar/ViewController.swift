//
//  ViewController.swift
//  Calendar
//
//  Created by kashee kushwaha on 29/05/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let weekLabel = [  "MON", "TUE", "WED", "THU", "FRI", "SAT" ,"SUN"]
    private var numberOfDays =  [ 0,0,0,0,0,0,0,0,0,0,0,0 ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let formatter = self.getFormatter()
        let year = formatter.string(for: Date())!
        formatter.dateFormat = "YYYY/MM/dd"

        for i in 0..<12 {
            let targetDay = String(format: "%@/%02d/01", year, i + 1)
            let target = formatter.date(from: targetDay)
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
            self.numberOfDays[i] = (calendar.range(of: .day, in: .month, for: target!)?.count)!
        }
    }

    func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        return formatter
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return    self.numberOfDays[4]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let dayLabel = cell.contentView.viewWithTag(1) as! UILabel
        let weekLabel = cell.contentView.viewWithTag(2) as! UILabel

        let formatter = self.getFormatter()
        let year = formatter.string(for: Date())!
        formatter.dateFormat = "YYYY/MM/dd"
        let targetDay = String(format: "%@/%02d/%02d", year, collectionView.tag + 1, indexPath.row + 1)
        let target = formatter.date(from: targetDay)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Kolkata")!
        let weekday = calendar.component(.weekday,from: target!)

        dayLabel.text = "\(indexPath.row + 1)"
        weekLabel.text = self.weekLabel[weekday - 1]
        
        if weekday == 1 {
            dayLabel.backgroundColor = UIColor.red
            dayLabel.textColor = UIColor.white
            dayLabel.layer.borderColor = UIColor.white.cgColor
            weekLabel.textColor = UIColor.red
        } else {
            dayLabel.backgroundColor = UIColor.white
            dayLabel.textColor = UIColor.black
            dayLabel.layer.borderColor = UIColor.black.cgColor
            weekLabel.textColor = UIColor.black
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let dayLabel = cell.contentView.viewWithTag(1) as! UILabel
        print(dayLabel.text!)
    }
}
