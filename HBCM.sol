pragma solidity ^0.8.0;
contract Collector{
address owner;
uint totalHospitals;
uint totalpatient;
uint totalUser;
uint totalBCM;
address Manager;
uint totalRecord;
address sender;
uint patientRequestNo;
uint patientApproveNo;
constructor(address _manager,address _sender,address _owner) public{
    owner=_owner;
    totalUser=0;
    Manager=_manager;
    totalRecord=0;
    sender=_sender;
    patientApproveNo=0;
    patientRequestNo=0;
}

function callKeccak256(string memory adhar) public pure returns(bytes32 result){
      return keccak256(adhar);
   }  

modifier onlyCollector(){
   
     require(msg.sender==owner,"Only Manager can access");
        _;
}
 
struct detailsForRegistration{
     string name;
     uint successfulCheckup;
     uint failureCheckup;
     string expertise;
}
mapping(bytes32=>detailsForRegistration) HospitalRecords;
mapping(bytes32=>bool) validateHospital;

function addHospital(string memory str,string memory exp) public onlyCollector{
    bytes32 n=callKeccak256(str);
    bool check=validateHospital[n];
    require(!check,"sorry this hospital is already registered");
    detailsForRegistration storage details=HospitalRecords[n];
    details.name=n;
    details.successfulCheckup=0;
    details.failureCheckup=0;
    details.expertise=exp; 
    validateHospital[n]=true;
    }

struct PatientDetails{
        string name;
        bytes age;
        string pincode;
        string diseaseType;
        bytes32 oldDetails;
    }
mapping(bytes=>uint) totalReport;
mapping(bytes32=>PatientDetails) usersRecords;
mapping(bytes32=>bool) isPatient;

function addNewPatient(string memory uname,string memory adhar,bytes32 a,string memory pin,string memory diseases,string memory olddetail) public onlyCollector{
    bytes32 hashValue=callKeccak256(adhar);
    require(isPatient[hashValue],"Already registered");
    PatientDetails storage details=usersRecords[hashValue];
    details.name=uname;
    details.pincode=pin;
    details.age=a;
    details.diseaseType=diseases;
    details.oldDetails=0;
    totalReport[hashValue]=0;
    isPatient[hashValue]=true;
    totalUser+=1;
}

struct BCM{
    address id;
    uint state;
}
mapping(address=>bool) isBCM;
mapping(uint=>mapping(address=>BCM)) BcmDetails;

function addBCM(address bcm,uint pin) public onlyCollector{
    require(!isBCM[bcm],"ID EXIT");
    mapping(address=>BCM) temp=BcmDetails[pin];
    BCM storage details=temp[bcm];
    details.id=bcm;
    details.state=pin;
    BcmDetails[pin]=temp;
    isBCM[bcm]=true;
}

modifier onlyHospital(string memory hospital){
    require(validateHospital[hospital],"you are not hospital"); 
    _;
 }

//********************new********************
struct transaction{
    string id;
    string disease;
}
uint trNo;
uint executedTrNo;

uint blocksize=5;

mapping(uint=>transaction) transactionCollection;

function data_to_collecter(string memory user_id, string memory _disease) public onlyHospital{
    transactionCollection[trNo]=transaction(user_id,_disease);
    trNo++;

}

 


}
