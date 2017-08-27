pragma solidity ^0.4.4;

contract ProvenFood {
  
  struct food {
    address origin;
    uint amount;
    uint weight;
    uint date;
    string name;
    uint historyLength;
    mapping (uint => address) history;
    mapping (uint => uint256) timestamps;
  }

  mapping (string => food) foods;

  function newFood(uint _weight, uint _amount, string _name, string _uniqueID){
    
    foods[_uniqueID] = food(msg.sender, _amount, _weight, now, _name, 0);
    foods[_uniqueID].history[foods[_uniqueID].historyLength] = msg.sender;
    foods[_uniqueID].timestamps[foods[_uniqueID].historyLength] = now;
    foods[_uniqueID].historyLength++;
    
  }

  function getOrigin(string _uniqueID) constant returns (address){
    return foods[_uniqueID].origin;
  }

  function getAmount(string _uniqueID) constant returns (uint){
    return foods[_uniqueID].amount;
  }

  function getWeight(string _uniqueID) constant returns (uint){
    return foods[_uniqueID].weight;
  }

  function getDate(string _uniqueID) constant returns (uint){
    return foods[_uniqueID].date;
  }

  function getName(string _uniqueID) constant returns (string){
    return foods[_uniqueID].name;
  }

  function getHistory(string _uniqueID) constant returns (address[],uint256[]){
    uint size = foods[_uniqueID].historyLength;
    address[] memory _history = new address[](size);
    uint256[] memory _timestamps = new uint256[](size);
    
    for (uint i = 0; i < foods[_uniqueID].historyLength; i++) { 
      _history[i] = foods[_uniqueID].history[i];
      _timestamps[i] = foods[_uniqueID].timestamps[i];
    }
    return (_history,_timestamps);
  }

  function signFood(string _uniqueID){
    
    foods[_uniqueID].history[foods[_uniqueID].historyLength] = msg.sender;
    foods[_uniqueID].timestamps[foods[_uniqueID].historyLength] = now;
    foods[_uniqueID].historyLength++;
    
  }
}