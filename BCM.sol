pragma solidity ^0.8.0;
import "../../HBCM/COLLECTOR/Sender.sol";
import "../../HBCM/COLLECTOR/Collector.sol";
import "../CONSENSUS/consensus.sol";
contract Manager is Sender,Consensus,Collector{
    modifier onlyManager(){
        require(msg.sender==manager,"Only Manager can access");
        _;
    }
    event approvePatientEvent(String msg);
    mapping(uint=>bytes32) userRequest;
    mapping(bytes32=>bool) userStatus;
    struct patientMediacalRecord{

    }
    mapping(bytes32=>mapping(uint=>patientMediacalRecord)) record;
    mapping(bytes32=>patientMediacalRecord) forUser;
    function addpatientRecord() public onlyManager{

    }
    function approvaPatientStatus() public onlyManager{
        if(patientApproveNo==patientRequestNo){
            patientApproveNo=0;
            patientRequestNo=0;
            emit approvaPatientStatus("All user request approved");
        }
        else{
            bytes32 id=userRequest[patientRequestNo];
            totalReport[id];
            require(totalReport[id]>0,"Not Checked yet");
            mapping(uint=>patientMediacalRecord) res=record[id];
            patientMediacalRecord storage r=res[totalReport[id]-1];
            forUser[id]=r;
            patientApproveNo++;
            emit approvaPatientStatus("successFul Approve");
        }
    }

   function gethashFromBCM()public onlyManager returns(bytes32) {
            int currTransactionNo=executedTrNo;
            transaction storage updatingInfo = transactionCollection[currTransactionNo];
            string memory str_id=updatingInfo.id;
            string memory str_disease=updatingInfo.disease;
            bytes32 hash1=keccak256(abi.encode(str_id, str_disease));
            return hash1;
    }

event giveResponseToTrNo(uint executedTrNo);

function mineBlock()public onlyCollector{
       if(trNo>=executedTrNo+blocksize){
      for(int i=0;i<blocksize;i++){
          emit giveResponseToTrNo(executedTrNo);
            bytes32 [10]responses;
            for(int resno=0;resno<10;resno++){
                
               responses[resno] = gethashFromBCM();
            }
            bytes32 val = consesusPBFT(responses);
            if(val==-1){

            }else{
                //data update
            }
            executedTrNo++;
      }
      trNo=trNo-blocksize;
    }
}  

    
}
