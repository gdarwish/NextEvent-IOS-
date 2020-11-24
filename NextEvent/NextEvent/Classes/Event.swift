//
//  Event.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-10-29.
//

import Foundation

class Event: Codable{
        
    init(id: String, title: String, description: String, start: String, location: [Double], country: String, category: String, entities: [Entity]) {
        self.id = id
        self.title = title
        self.description = description
        self.start = start
        self.location = location
        self.country = country
        self.category = category
        self.entities = entities
    }
    
    var id: String
    var title: String
    var description: String
    var start: String
    var location: [Double]
    var country: String
    var category: String
    var entities: [Entity]
    var image: String = ""
    var address: String {
        get {
            return entities.count == 0 ? "Not available" : entities[0].formatted_address
        }
    }

    private enum CodingKeys: String, CodingKey {
       case id, title,  description, start, location, country, category, entities
    }
    
    func dateFormatted() -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: start) {
            return dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        return "No Date"
    }
    
    func getLongitude() -> Double{
        if location.count >= 2{
            return location[0]
        }else{
            return 0
        }
    }

    func getLatitude() -> Double{
        if location.count >= 2{
            return location[1]
        }else{
            return 0
        }
    }

    func getImage() -> String{
        switch category {
        case "school-holidays":
            image = "https://gdarwish.scweb.ca/NextEventImages/Schoolholidays.png";
            break;
        case "public-holidays":
            image = "https://gdarwish.scweb.ca/NextEventImages/Publicholidays.png";
            break;
        case "observances":
            image = "https://gdarwish.scweb.ca/NextEventImages/Observances.png";
            break;
        case "politics":
            image = "https://gdarwish.scweb.ca/NextEventImages/Politics.png";
            break;
        case "conferences":
            image = "https://gdarwish.scweb.ca/NextEventImages/Conferences.png";
            break;
        case "expos":
            image = "https://gdarwish.scweb.ca/NextEventImages/Expos.png";
            break;
        case "festivals":
            image = "https://gdarwish.scweb.ca/NextEventImages/Festivals.png";
            break;
        case "performing-arts":
            image = "https://gdarwish.scweb.ca/NextEventImages/Performingarts.png";
            break;
        case "community":
            image = "https://gdarwish.scweb.ca/NextEventImages/Community.png";
            break;
        case "sports":
            image = "https://gdarwish.scweb.ca/NextEventImages/Sports.png";
            break;
        case "daylight-savings":
            image = "https://gdarwish.scweb.ca/NextEventImages/Daylightsavings.png";
            break;
        case "airport-delays":
            image = "https://gdarwish.scweb.ca/NextEventImages/Airportdelays.png";
            break;
        case "severe-weather":
            image = "https://gdarwish.scweb.ca/NextEventImages/Severeweather.png";
            break;
        case "disasters":
            image = "https://gdarwish.scweb.ca/NextEventImages/Disasters.png";
            break;
        case "terror":
            image = "https://gdarwish.scweb.ca/NextEventImages/Terror.png";
            break;
        case "concerts":
            image = "https://gdarwish.scweb.ca/NextEventImages/Concerts.png";
            break;
        default:
            image = "default image";
        }
        return image;
    }
}
