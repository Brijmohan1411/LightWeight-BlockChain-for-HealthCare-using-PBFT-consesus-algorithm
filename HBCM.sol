pragma solidity ^0.8.0;

contract HBCM{

    struct tr{
        address id;
        address hId;
        string disease;
        address doctorId;
    }

    mapping(uint=>tr) trColl;
    uint trNo=0;
    uint trIncludedNo=0;

    tr[5] block;
    mapping( uint => block ) mapLT;
    uint blockNo=0;
    uint currBlock=0;

    struct ledger{
        uint IVorV;
        string disease;
        address hId;
        address doctorId;
    }
    mapping( address => arr )mapLVT;
    
    function mineBlock() public onlyHBCM{
        block b;
        if(trNo-trIncludedNo >= 5){
            for(int i=0;i<5;i++){
               b[i]=trColl[trIncludedNo++];
            }
            mapLT[blockNo]=b;
        }
    }

    function addBCM() public onlyHBCM(string memory _name,address _id,string memory _state)only onlyHBCM{
         require(bcmColl[_id].isBCM==false,"already BCM");
         bcmColl[_id]=bcm(_name,_id,_state,true);
    }

    function removeBCM()public onlyHBCM{
         require(bcmColl[_id].isBCM==true,"not a BCM");
         delete bcmColl[_id];

    }

    function consesusPBFT(){

    }



}