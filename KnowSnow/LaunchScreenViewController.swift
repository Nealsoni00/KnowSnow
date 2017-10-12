//
//  LaunchScreenViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/24/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard


class LaunchScreenViewController: UIViewController {
    private let dbInstance = RetrieveMapInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //maybe add?
        createParticles()
        
        done()
        
    
        //get percentages then go to PercentagesRecievedRetrieveWeather
        //make delegate work
        // Do any additional setup after loading the view.
        
        //Get percentages, send message back, on message back get weather stuff, weather sends message, on that message perform segue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done() {
//        defaults.removeObject(forKey: "default")
//        defaults.set("westport", forKey: "default")

        let defaultSchool = defaults.string(forKey: "default")
        if (defaultSchool != nil) {
            //this works
            dbInstance.initFunc(date: Date().tomorrow)
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = tabBarController
        } else {
            
            //push to settings vcremind
            print("Initial install")
            dbInstance.initialInstall(date: Date().tomorrow)
            //running code but NOT showing the vc
//            present(settingsVC, animated: true, completion: nil)
            
//            UIApplication.topViewController()?.present(settingsVC, animated: true, completion: nil)
           
            
            
        }
        
      
    }
   

    func createParticles() {
        let view = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        view.contentMode = UIViewContentMode.scaleAspectFill
        
        self.view.addSubview(view)
        
        let cloud = CAEmitterLayer()
        cloud.emitterPosition = CGPoint(x: view.center.x, y: -50)
        cloud.emitterShape = kCAEmitterLayerLine
        cloud.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let flake = makeEmitterCell()
        
        cloud.emitterCells = [flake]
        
        view.layer.addSublayer(cloud)
    }
    
    func makeEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = 8
        cell.birthRate = 4
        cell.lifetime = 50.0
        cell.velocity = 55
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0.7
        cell.spinRange = 1.2
        cell.scaleRange = -0.05
        cell.contents = UIImage(named: "snow")?.cgImage
        
        return cell
    }
    

}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}






