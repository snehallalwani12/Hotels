//
//  HotelListAPI.swift
//  Hotels
//
//  Created by snehal_lalwani on 24/04/18.
//

import UIKit

class HotelListAPI: NSObject
{
    func getHotelData()
    {
        let url = URL(string: HOTEL_LIST_API_URL)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else
            {
                DispatchQueue.main.async
                    {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: HOTEL_LIST_API_NOTIFICATION), object: error?.localizedDescription)
                }
                return
            }
            guard let data = data else
            {
                DispatchQueue.main.async
                    {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: HOTEL_LIST_API_NOTIFICATION), object:SERVER_ERROR_MESSAGE)
                }
                return
            }
            
            let rawJsonText : String! = String(data: data, encoding: .utf8)
            let dictionary = (try? JSONSerialization.jsonObject(with: rawJsonText.data(using: .utf8) ?? Data(), options: .mutableContainers)) as? [AnyHashable: Any]
            DispatchQueue.main.async
                {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: HOTEL_LIST_API_NOTIFICATION), object: dictionary)
            }
        }

        task.resume()

    }

}
