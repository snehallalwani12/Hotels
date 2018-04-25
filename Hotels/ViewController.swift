//
//  ViewController.swift
//  Hotels
//
//  Created by snehal_lalwani on 24/04/18.
//

import UIKit

class HotelTableViewCell : UITableViewCell
{
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var hotelTimingsLabel: UILabel!
    @IBOutlet weak var hotelcallButton: UIButton!
    @IBOutlet weak var abackgroundView: UIView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var hotelTableView: UITableView!
    
    var hotelArray : NSMutableArray = NSMutableArray()
    var spinner : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hotelTableView.tableFooterView = UIView(frame: .zero)
        
        self.view.addSubview(spinner)
        spinner.center = self.view.center
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        self.hotelTableView.isHidden = true
        self.errorLabel.isHidden = true
        
        spinner.startAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.HotelDataNotification(_:)), name:NSNotification.Name(rawValue: HOTEL_LIST_API_NOTIFICATION), object: nil)
        HotelListAPI().getHotelData();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.customizeNavigationBar()
    }
    
    func customizeNavigationBar()
    {
        let leftItem = UIBarButtonItem(title: "Hotels", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        leftItem.isEnabled = false
        leftItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func HotelDataNotification(_ notification: Notification)
    {
        spinner.stopAnimating()
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: HOTEL_LIST_API_NOTIFICATION), object:nil)
        
        if (notification.object is String)
        {
            self.errorLabel.text = notification.object as? String
            self.errorLabel.isHidden = false
            self.hotelTableView.isHidden = true
        }
        else
        {
            let tempArray : NSMutableArray = DataManager.sharedInstance.makeDataModel(notification.object as! NSDictionary)
            if tempArray.count != 0
            {
                let descriptor: NSSortDescriptor = NSSortDescriptor(key:"distance", ascending: true)

                hotelArray = NSMutableArray(array: tempArray.sortedArray(using: [descriptor]))
                self.hotelTableView.reloadData()
                self.errorLabel.isHidden = true
                self.hotelTableView.isHidden = false
            }
            else
            {
                self.errorLabel.text = SERVER_ERROR_MESSAGE
                self.errorLabel.isHidden = false
                self.hotelTableView.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return hotelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelTableViewCell", for: indexPath) as! HotelTableViewCell
        
        let hotelObj : HotelObject = hotelArray.object(at: indexPath.row) as! HotelObject
        cell.hotelNameLabel.text = hotelObj.outletName
        cell.hotelAddressLabel.text = hotelObj.address
        cell.hotelTimingsLabel.text = hotelObj.timings
        
        cell.hotelcallButton.addTarget(self, action: #selector(ViewController.callAction), for: .touchUpInside)
        cell.hotelcallButton.tag = indexPath.row
        
        cell.abackgroundView.layer.cornerRadius = 7.0
        cell.abackgroundView.layer.shadowColor = UIColor.black.cgColor
        cell.abackgroundView.layer.shadowRadius = 3
        cell.abackgroundView.layer.shadowOpacity = 1.0
        cell.abackgroundView.clipsToBounds = true
        
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func callAction(sender: UIButton)
    {
        let buttonTag = sender.tag
        let hotelObj : HotelObject = hotelArray.object(at: buttonTag) as! HotelObject
        let phoneNumber = hotelObj.phoneNumber
        if let url = URL(string: "tel://\(String(describing: phoneNumber))"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}

