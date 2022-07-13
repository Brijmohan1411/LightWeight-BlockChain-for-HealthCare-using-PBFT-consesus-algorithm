pragma solidity ^0.8.0;
import "../../BCM/MANAGER/Manager.sol";
import "../../HBCM/COLLECTOR/Collector.sol";
contract Patient is Collector,Manager{
    modifier onlyPatitent(string memory adhar){
        bytes32 validate=callKeccak256(adhar);
        require(isPatient[validate],"sry you are not user");
    }


   event userMsg(string res);
   event userReportEvent();
    function requestReport(string memory adhar) public onlyPatient(adhar){
        bytes32 id=callKeccak256(adhar);
        require(!userStatus[id],"Already Requested");
        userRequest[patientRequestNo]=id;
        patientRequestNo++;
        userStatus[id]=true;
        emit userMsg("successFul done");
    }

    function checkReport(string memory adhar) public onlyPatient(adhar){
        bytes32 id=callKeccak256(adhar);
        require(!userStatus[id],"in queue wait for approval");
        emit userReportEvent();

    }
}
