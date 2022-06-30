pragma solidity ^0.8.0;

contract BCM{

    struct bcm{

        string name;
        address id;
        string state;
        bool isBCM;
       // uint totalResponses;
       // uint totalCorrectResponses;
    }
    mapping(address => bcm ) bcmColl;

    uint[5] responseArray;
    mapping(uint=>responseArray) responseColl;
   // mapping(uint=>address) resToResponserMap;
    uint totalRes;


    function getNextBlock() public view {

    }
    function response(uint res1,uint res2,uint res3,uint res4,uint res5)public onlyBCM(){
          require(res1==0||res1==1||
                  res2==0||res2==1||
                  res3==0||res3==1||
                  res4==0||res4==1||
                  res5==0||res5==1  ,"incorrect input, u can enter only 0 0r 1 as input");
                  uint[5] array;
                
                  array[0]=res1;
                  array[1]=res2;
                  array[2]=res3;
                  array[3]=res3;
                  array[4]=res4;
                     

                   responseColl[totalRes++]=array;
    }

    function updateLedgerVTorIVT() onlyHBCM {
        for(uint i=0;i<5;i++){
            int cntV=0;     //count of valid responses
            for(uint res=0;res<totalRes;res++){
              if(responseColl[res].[i] == 1){
                  cntV++;
                  responseColl[res].[i] == 0; //preparation doing for next block;
              }
          }
          uint v=0;     //v=1 for valid and 0 for invalid
          
          if((cntV/totalRes)>(2/3)){
              v=1;
          }
         tr t=mapLT[currBlock].[i];         // tr is transaction of which validation is being checked
         address uAdd=mapLT[currBlock].[i].id;
         mapLVT[uAdd].push(ledger(v, t.disease,t.hId,t.doctorId));

       


        }

         //preparation for next block validation;
       totalRes=0;
       
     }

}