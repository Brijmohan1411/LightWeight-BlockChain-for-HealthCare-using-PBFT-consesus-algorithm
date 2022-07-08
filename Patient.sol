pragma solidity ^0.8.0;

contract Patient{

    struct patient{
        string name;
        bool isUser;
        address id;
        uint adharNo;
        string state;
    }
    mapping( address => patient ) patients;

    function register(string memory _name,address _id,uint _adhar,string memory _state)public {
        require(patients[_id].isUser==false,"already registered");
        patients[_id]=patient(_name,_id,true,_adhar,_state);
    }

    function updateRequest(address _hId, string memory _disease,address _doctorId){
        require(patients[msg.sender].isUser==true,"sorry, you are not registered yet");
        //here transaction is added to trMap(trColl) and will be waiting to be included in a block;
        trColl[trNo++]=tr(msg.sender,_hId,_disease,_doctorId); 
    }

   

}
