//
//  DataManager.swift
//  Hotels
//
//  Created by snehal_lalwani on 24/04/18.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    func makeDataModel(_ responseDict : NSDictionary) ->  NSMutableArray
    {
        let hotelArray : NSMutableArray = NSMutableArray()
        
        if (responseDict.object(forKey: "data") != nil)
        {
            let dataDict = responseDict.object(forKey: "data") as! NSDictionary
            for key in dataDict.allKeys
            {
                if(dataDict.object(forKey: key) != nil)
                {
                    let hotelDict = dataDict.object(forKey: key) as! NSDictionary
                    let hotelObj : HotelObject = HotelObject()
                    
                    if let subFranchiseID = hotelDict["SubFranchiseID"] as? String {
                        hotelObj.subFranchiseID = subFranchiseID
                    }
//                    if(hotelDict.object(forKey: "OutletID") != nil)
//                    {
//                        hotelObj.outletID = hotelDict.object(forKey: "OutletID") as! String
//                    }
                    if let outletName = hotelDict["OutletName"] as? String {
                        hotelObj.outletName = outletName
                    }
//                    if(hotelDict.object(forKey: "BrandID") != nil)
//                    {
//                        hotelObj.brandID = hotelDict.object(forKey: "BrandID") as! String
//                    }
                    if let address = hotelDict["Address"] as? String {
                        hotelObj.address = address
                    }
//                    if(hotelDict.object(forKey: "NeighbourhoodID") != nil)
//                    {
//                        hotelObj.neighbourhoodID = hotelDict.object(forKey: "NeighbourhoodID") as! String
//                    }
//                    if(hotelDict.object(forKey: "CityID") != nil)
//                    {
//                        hotelObj.cityID = hotelDict.object(forKey: "CityID") as! String
//                    }
                    if let email = hotelDict["Email"] as? String {
                        hotelObj.email = email
                    }
                    if let timings = hotelDict["Timings"] as? String {
                        hotelObj.timings = timings
                    }
//                    if(hotelDict.object(forKey: "CityRank") != nil)
//                    {
//                        hotelObj.cityRank = hotelDict.object(forKey: "CityRank") as! String
//                    }
//                    if(hotelDict.object(forKey: "Latitude") != nil)
//                    {
//                        hotelObj.latitude = hotelDict.object(forKey: "Latitude") as! String
//                    }
//                    if(hotelDict.object(forKey: "Longitude") != nil)
//                    {
//                        hotelObj.longitude = hotelDict.object(forKey: "Longitude") as! String
//                    }
//                    if(hotelDict.object(forKey: "Pincode") != nil)
//                    {
//                        hotelObj.pincode = hotelDict.object(forKey: "Pincode") as! String
//                    }
//                    if(hotelDict.object(forKey: "Landmark") != nil)
//                    {
//                        hotelObj.landmark = hotelDict.object(forKey: "Landmark") as! String
//                    }
//                    if(hotelDict.object(forKey: "Streetname") != nil)
//                    {
//                        hotelObj.streetname = hotelDict.object(forKey: "Streetname") as! String
//                    }
//                    if(hotelDict.object(forKey: "BrandName") != nil)
//                    {
//                        hotelObj.brandName = hotelDict.object(forKey: "BrandName") as! String
//                    }
//                    if(hotelDict.object(forKey: "OutletURL") != nil)
//                    {
//                        hotelObj.outletURL = hotelDict.object(forKey: "OutletURL") as! String
//                    }
//                    if(hotelDict.object(forKey: "NumCoupons") != nil)
//                    {
//                        hotelObj.numCoupons = hotelDict.object(forKey: "NumCoupons") as! String
//                    }
//                    if(hotelDict.object(forKey: "Pincode") != nil)
//                    {
//                        hotelObj.pincode = hotelDict.object(forKey: "Pincode") as! String
//                    }
//                    if(hotelDict.object(forKey: "NeighbourhoodName") != nil)
//                    {
//                        hotelObj.neighbourhoodName = hotelDict.object(forKey: "NeighbourhoodName") as! String
//                    }
//                    if(hotelDict.object(forKey: "PhoneNumber") != nil)
//                    {
//                        hotelObj.phoneNumber = hotelDict.object(forKey: "PhoneNumber") as! String
//                    }
//                    if(hotelDict.object(forKey: "CityName") != nil)
//                    {
//                        hotelObj.cityName = hotelDict.object(forKey: "CityName") as! String
//                    }
                    if let distance = hotelDict["Distance"] as? NSString {
                        hotelObj.distance = distance as String!
                    }
//                    if(hotelDict.object(forKey: "CoverURL") != nil)
//                    {
//                        hotelObj.coverURL = hotelDict.object(forKey: "CoverURL") as! String
//                    }
                    
                    hotelArray.add(hotelObj)
                }
            }
        }
        
        return hotelArray;
    }

}
