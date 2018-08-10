//
//  TimerViewController.swift
//  SmitivApp
//
//  Created by Suresh on 08/08/18.
//  Copyright © 2018 SmitivApp. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var startButton: UIButton!
    //@IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 2100
    var timer = Timer()
    
    var isTimerRunning = false
    var resumeTapped = false
    
    //MARK: - IBActions
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        //pauseButton.isEnabled = true
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            //self.pauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            //self.pauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 2100
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        //pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            // timerLabel.text = String(seconds)
            //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        //    let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        //return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.title = "Timer"
        UserDefaults.standard.set(seconds, forKey: "SecondsActualIntilazation")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: .UIApplicationWillEnterForeground,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidEnterBackGround),
                                               name: .UIApplicationDidEnterBackground,
                                               object: nil)
        
        //pauseButton.isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIApplicationWillEnterForeground,
                                                  object: nil)
        
        
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIApplicationDidEnterBackground,
                                                  object: nil)
        
        
    }
    
    @objc func applicationDidBecomeActive() {
        let date1 = UserDefaults.standard.object(forKey: "background") as! Date
        let date2 = Date()
        let diff = Int(date2.timeIntervalSince1970 - date1.timeIntervalSince1970)
        
        //     let hours = diff / 3600
        //   let minutes = (diff - hours * 3600) / 60
        //let secondsdiff =  Int(diff) % 60
        
        //let intialseconds =  UserDefaults.standard.integer(forKey: "SecondsActualIntilazation")
        
        let currentseconds =  UserDefaults.standard.integer(forKey: "currentseconds")
        
        seconds = currentseconds - diff
        runTimer()
        isTimerRunning=true
        
    }
    
    @objc func applicationDidEnterBackGround(){
        
        UserDefaults.standard.set(seconds, forKey: "currentseconds")
        
        timer.invalidate();
        isTimerRunning = false
    }
}



