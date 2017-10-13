import UIKit

//Creating the getMilk() function
//func getMilk(){
//    print("go to the shops")
//    print("buy 2 cartons of milk")
//    print("pay £2")
//    print("come home")
//}

//func getMilk(howManyMilkCartons : Int){
//    let costOfMilk = 2
//    
//    print("go to the shops")
//    print("buy \(howManyMilkCartons) cartons of milk")
//    print("pay £\(howManyMilkCartons * costOfMilk)")
//    print("come home")
//}

func getMilk(howManyMilkCartons : Int, howMuchRobotWasGiven : Int) -> Int {
    let costOfMilk = 2
    
    print("go to the shops")
    print("buy \(howManyMilkCartons) cartons of milk")
    print("pay £\(howManyMilkCartons * costOfMilk)")
    print("come home")
    
    return howMuchRobotWasGiven - (howManyMilkCartons * costOfMilk)
}

//Calling the getMilk() function
var numOfMilkCartons : Int = 3
var changeGiven : Int = 10

var amountOfChange = getMilk(howManyMilkCartons: numOfMilkCartons, howMuchRobotWasGiven: changeGiven)
