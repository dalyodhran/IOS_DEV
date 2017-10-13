import UIKit

func bmiCal(mWeight : Double, mHeight : Double) -> String {
    let bmi = mWeight / (mHeight * mHeight)
    
    if bmi > 25 {
        return "Your BMI is \(bmi) you are over weight"
    } else if bmi > 18.5 && bmi < 25 {
        return "Your BMI is \(bmi) you are normal weight"
    } else {
        return "Your BMI is \(bmi) you are over underweight"
    }
}

print(bmiCal(mWeight: 80, mHeight: 1.79))
