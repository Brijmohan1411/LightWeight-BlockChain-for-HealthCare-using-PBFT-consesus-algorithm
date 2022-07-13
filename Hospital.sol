// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "../../HBCM/COLLECTOR/Collector.sol";
contract Hospital is Collector{

 modifier onlyHospital(string memory hospital){
    require(validateHospital[hospital],"you are not hospital"); 
 }
event userEvent(string name,bytes age,string pincode,string diseaseType,string oldDetails);
function getPatientDetails(string memory hospital,string user_id) public onlyHospital(hospital){
   bytes32 id=callKeccak256(user_id);
   require(isPatient[id],"patient details does not exist");
   PatientDetails storage details=usersRecords[user_id];
   emit userEvent(details.name,details.age,details.pincode,details.diseaseType,details.oldDetails);
}

//********************new*************
function updatePatientDetails(string memory user_id, string memory _disease){
   bytes32 id=callKeccak256(user_id);
   require(isPatient[id],"patient details does not exist");
  
  // hospital is sending details of patient to collecter
  data_to_collecter(user_id,_disease); 
  
}


}
