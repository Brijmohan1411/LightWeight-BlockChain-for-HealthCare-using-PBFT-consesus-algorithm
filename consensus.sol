pragma solidity ^0.8.0;

contract Consensus{
 function consesusPBFT(bytes32 []arr) external returns(bytes32){
    int c=0;
    mapping(uint=>bytes32) validate;
    mapping(bytes32=>uint) totalCount;
    mapping(bytes32=>bool) isPresent;
    for(int i=0;i<arr.length;i++){
        bytes32 hash_Value=arr[i];
        bool check=isPresent[hash_Value];
        if(check){
            uint count=totalCount[hash_Value];
            count+=1;
            totalCount[hash_Value]=c;
        }
        else{
            isPresent[hash_Value]=true;
            totalCount[hash_Value]=1;
            validate[c]=hash_Value;
            c++;
        }
    }
    uint max=0;
    bytes32 res=-1;
    for(uint i=0;i<c;i++){
        bytes32 hash_Value=validate[i];
        uint count=totalCount[hash_Value];
        if(max<count){
            res=hash_Value;
            max=count;
        }
    }
    uint v=(arr.length*2)/3;
    if(max>v)
        return res;
    return -1;
    }
}
