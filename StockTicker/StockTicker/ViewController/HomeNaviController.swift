//
//  HomeNaviController.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-14.
//

import UIKit

class HomeNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let newNavBarAppearance = customNavBarAppearance()
        self.navigationBar.standardAppearance = newNavBarAppearance
        self.navigationBar.scrollEdgeAppearance = newNavBarAppearance
        self.navigationBar.tintColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Apply left title position.
        let barAppearance = self.navigationBar.standardAppearance
        barAppearance.titlePositionAdjustment = UIOffset(horizontal: -self.navigationBar.center.x, vertical: 0)
        self.navigationBar.standardAppearance = barAppearance
        self.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        
        // Apply a grey background.
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = .darkGray
        
        // Apply white colored normal and large titles.
        let newTitleTextFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let newTitleTextColor = UIColor.white
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: newTitleTextColor, .font: newTitleTextFont]
        customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        // Apply white color to all the nav bar buttons.
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: newTitleTextColor, .font: newTitleTextFont]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: newTitleTextColor]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: newTitleTextColor]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: newTitleTextColor]
        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        return customNavBarAppearance
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

