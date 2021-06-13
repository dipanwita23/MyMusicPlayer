//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by Dipanwita Bardhan on 13/06/21.
//

import UIKit

class ViewController: UIViewController , CAPSPageMenuDelegate{
    @IBOutlet weak var tabContainer: UIView!
    

    var pageMenu : CAPSPageMenu!
    var controllerArray : [UIViewController] = []
    var index : Int = 0
    var guruDataDict = [String:String]()
    //var guru_Desc = [String:String]()
    var guruInitial : String?
    var pageHeader : String!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addingAllView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
            
            controllerArray = []
            addingAllView()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addingAllView() {
        
        let header1 = self.storyboard!.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        header1.title = "List 1"
        header1.inx = 0
        controllerArray.append(header1)
        
        let header2 = self.storyboard!.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        header2.title = "List 2"
        header1.inx = 1
        controllerArray.append(header2)
        
      
        
        
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemFont(UIFont(name: "HelveticaNeue-Bold", size: 17.0)!),
            //.menuItemWidthBasedOnTitleTextWidth(true),
            //.unselectedMenuItemLabelColor(Colors.lightBlue),
            .unselectedMenuItemLabelColor(UIColor.red),
            .selectedMenuItemLabelColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            .menuHeight(40.0),
            .menuItemSeparatorWidth(0.0),
            .menuMargin(10.0),
            .menuItemWidth((tabContainer.frame.width - 20.0)/2),
            .centerMenuItems(true)
            
        ]
        print("Parameters : \(parameters)")
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: tabContainer.frame.width, height: tabContainer.frame.height), pageMenuOptions: parameters)
        tabContainer.backgroundColor = UIColor.clear
        
        tabContainer.addSubview(pageMenu!.view)
        
        pageMenu.delegate = self
        
        
        pageMenu.moveToPage(index)
        
    }
    
    
    
    
    
  
}

