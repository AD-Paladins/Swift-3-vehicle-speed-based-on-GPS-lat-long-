
import UIKit
import Foundation
import Darwin

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

class RutasSpeedCalculator{
    
    private func calcularDistanciaCon(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double{
        
        // Convert degrees to radians
        let lat1 = lat1 * Double.pi / 180.0;
        let lon1 = lon1 * Double.pi / 180.0;
        
        let lat2 = lat2 * Double.pi / 180.0;
        let lon2 = lon2 * Double.pi / 180.0;
        
        // radius of earth in metres
        let r = 6378100.00
        
        // P
        let rho1 = r *  cos(lat1);
        let  z1 = r  * sin(lat1);
        let  x1 = rho1 * cos(lon1);
        let  y1 = rho1 * sin(lon1);
        
        // Q
        let  rho2 = r * cos(lat2);
        let  z2 = r * sin(lat2);
        let  x2 = rho2 * cos(lon2);
        let  y2 = rho2 * sin(lon2);
        
        // Dot product
        let  dot = (x1 * x2 + y1 * y2 + z1 * z2);
        let  cos_theta = dot / (r * r);
        
        let theta = acos(cos_theta);
        
        // Distance in Metres
        return r * theta;
    }
    
    func calcularVelocidadCon(lat1: Double, lon1: Double, lat2: Double, lon2: Double, tiempo1: Date, tiempo2: Date) -> Double{
        
        let dist = calcularDistanciaCon(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        
        let start = tiempo1
        let enddt = tiempo2
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([ .second])
        let datecomponenets = calendar.dateComponents(unitFlags, from: start, to: enddt)
        let seconds = datecomponenets.second
        
        let speed_mps = Double(dist)/Double(seconds!)
        let speed_kph = (Double(speed_mps) * 3600.0) / 1000.0
        
        return speed_kph.truncate(places: 2)
    }
}

let dateStart = Date()
let calendar = Calendar.current
let dateEnd = calendar.date(byAdding: .second, value: 2, to: dateStart)

let ruta = RutasSpeedCalculator()
let velocidad = ruta.calcularVelocidadCon(
    lat1: -2.192473,
    lon1: -79.879628,
    lat2: -2.189060,
    lon2: -79.878459,
    tiempo1: dateStart,
    tiempo2: dateEnd!
)

print(velocidad)
