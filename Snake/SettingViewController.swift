//
//  SettingViewController.swift
//  Snake
//
//  Created by User08 on 2019/1/3.
//

import UIKit

class SettingViewController: UIViewController {
    var setting=Setting.readLoversFromFile()
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var speedLabel: UITextField!
    @IBAction func nameChange(_ sender: Any) {
        setting?.name=nameLabel.text!
    }
   
    @IBAction func speedChange(_ sender: UIButton) {
        if sender.titleLabel?.text=="+"{
            if let sp=setting?.speed{
                if sp != 20{
                    setting?.speed+=1
                }
            }
        }
        if sender.titleLabel?.text=="-"{
            if let sp=setting?.speed{
                if sp != 0{
                    setting?.speed-=1
                }
            }
        }
        speedLabel.text=String(format: "%02i", (setting?.speed)!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let setting = setting{
            nameLabel.text=setting.name
            speedLabel.text=String(format: "%02i", setting.speed)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Setting.saveToFile(setting: setting!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
