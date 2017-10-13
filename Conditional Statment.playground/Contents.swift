import UIKit

func loveCalculator(yourName : String, theirName : String) -> String {
    
    let loveScore = Int(arc4random_uniform(101))
    
    if loveScore > 80 {
        return "Your made for each other"
    } else {
        return "No love is possible"
    }
    
}

print(loveCalculator(yourName: "Odhran", theirName: "Jack"))