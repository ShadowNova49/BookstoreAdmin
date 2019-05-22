//
//  warehouseRequestManager.swift
//  BookstoreAdmin
//
//  Created by Nikita on 09.12.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import Foundation

class warehouseRequstManager {
    
    static func getWarehouseData(completionHandler: @escaping ([dbWarehouse], NSError?) -> Void) {
        
        var funcArray = [dbWarehouse]()
        
        let URL_GET_BOOK = "http://192.168.207.130/mws_v2/getWarehouseData.php"
        
        //created NSURL
        let requestURL = NSURL(string: URL_GET_BOOK)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                var getJSON: NSDictionary!
                getJSON =  try JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments) as? NSDictionary
                print(getJSON) //Response result
                let transactions: NSArray = getJSON["transactions"] as! NSArray
                print(transactions)
                
                for i in 0 ..< transactions.count {
                    /*
                    funcArray.append(dbTransactions(id: (transactions[i] as! NSDictionary)["transID"] as! String!,
                                                    type: "selling",
                                                    custID: (transactions[i] as! NSDictionary)["custID"] as! String!,
                                                    ISBN: (transactions[i] as! NSDictionary)["ISBN"] as! String!,
                                                    orderDate: (transactions[i] as! NSDictionary)["orderDate"] as! String!,
                                                    amount: (transactions[i] as! NSDictionary)["amount"] as! String!,
                                                    sellerID: (transactions[i] as! NSDictionary)["sellerID"] as! String!,
                                                    cardNum: (transactions[i] as! NSDictionary)["cardNum"] as! String!,
                                                    price: (transactions[i] as! NSDictionary)["sellingPrice"] as! String!))
                    completionHandler(funcArray, nil)
                    */
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
            }.resume()
    }
}
