
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract wallet {
    
    uint32 public timestamp;
    uint16 constant WITHOUT_COMISSION_FLAG = 0;
    uint16 constant WITH_COMISSION_FLAG = 1;
    uint16 constant SEND_ALL_AND_DESTROY_FLAG = 160;


    constructor() public {
        
        require(tvm.pubkey() != 0, 101);
        
        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();

        timestamp = now;
    }

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    function sendValueWithComission(address dest, uint128 amount, bool bounce) public view checkOwnerAndAccept {
        dest.transfer(amount, bounce, WITH_COMISSION_FLAG);
    }

    function sendValueWithoutComission(address dest, uint128 amount, bool bounce) public view checkOwnerAndAccept {
        dest.transfer(amount, bounce, WITHOUT_COMISSION_FLAG);
    }

    function sendAllAndDestroy(address dest, bool bounce) public view checkOwnerAndAccept {
        dest.transfer(0, bounce, SEND_ALL_AND_DESTROY_FLAG);
    }


}
