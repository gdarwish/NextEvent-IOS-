//
//  Event.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-10-29.
//

import Foundation

class Event: Codable{
    
    init(id: String, title: String, description: String, start: String, location: [Double], country: String, category: String) {
        self.id = id
        self.title = title
        self.description = description
        self.start = start
        self.location = location
        self.country = country
        self.category = category
    }
    
    var id: String
    var title: String
    var description: String
    var start: String
    var location: [Double]
    var country: String
    var category: String
    
    
    var image: String = ""

    private enum CodingKeys: String, CodingKey {

        
       case id, title,  description, start, location, country, category
        
        
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

