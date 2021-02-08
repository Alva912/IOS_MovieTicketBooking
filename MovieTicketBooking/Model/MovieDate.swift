//
//  MovieDate.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 8, 2021

import Foundation
import SwiftyJSON


class MovieDate : NSObject, NSCoding{

    var maximum : String!
    var minimum : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        maximum = json["maximum"].stringValue
        minimum = json["minimum"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if maximum != nil{
        	dictionary["maximum"] = maximum
        }
        if minimum != nil{
        	dictionary["minimum"] = minimum
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		maximum = aDecoder.decodeObject(forKey: "maximum") as? String
		minimum = aDecoder.decodeObject(forKey: "minimum") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if maximum != nil{
			aCoder.encode(maximum, forKey: "maximum")
		}
		if minimum != nil{
			aCoder.encode(minimum, forKey: "minimum")
		}

	}

}
