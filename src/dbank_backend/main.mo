import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";

//actor acts similar to class
//chimpanzee
actor DBank
{//stable makes it persistent after restarting it retains previous old value
  stable var currentValue: Float = 300;
  //first comment out currentvalue then dfx start then uncomment it
  currentValue:=300;
  //Debug.print(debug_show(currentValue));

//time function
stable var startTime = Time.now();
//first comment out currentvalue then dfx start then uncomment it
startTime := Time.now();

Debug.print(debug_show(startTime));

  public func topUp(amount:Float)
  {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };
//topUp();
public func withdraw(amount:Float)
  {
    if(currentValue>=amount)
    {
      currentValue -= amount;
    Debug.print(debug_show(currentValue));
    }
    else{
      Debug.print("less amount than being withdrawed");
    }
  };
//query function are way more faster
  public query func checkBalance(): async Float{
    return currentValue;
  };

//creating a compound function for compound interest
//let roi be 1 percent

  public func compound(): async Float
  {
    //float is used because they have already been setup to float
    let currentTime = Time.now();
  let elapsedTime_in_nanosec = currentTime - startTime;
  let elapsedTime_in_sec = elapsedTime_in_nanosec / 1000000000;
  let growthFactor = 1.01;
  let compoundValue = currentValue * Float.pow(growthFactor, Float.fromInt(elapsedTime_in_sec));
  currentValue:=compoundValue;
  return currentValue
  }

}
