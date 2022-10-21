pragma solidity ^0.5.0;
import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
// Bootstrap the KaseiCoinCrowdsale contract by inheriting the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint256 rate, // rate in TKNbits
        address payable wallet, // sale beneficiary
        KaseiCoin token // the KaseiCoin itself that the KaseiCoinCrowdsale will work with
    ) public Crowdsale(rate, wallet, token) {
        // constructor can stay empty
    }
}
contract KaseiCoinCrowdsaleDeployer {

    address public kasei_token_address;

    address public kasei_crowdsale_address;
   
    constructor(
        //string memory name,
        //string memory symbol,
        address payable wallet 
    ) public {
        KaseiCoin token = new KaseiCoin(0);
        kasei_token_address = address(token);
        KaseiCoinCrowdsale kasei_crowdsale =
            new KaseiCoinCrowdsale(1, wallet, token);

        kasei_crowdsale_address = address(kasei_crowdsale);

        token.addMinter(kasei_crowdsale_address);

        token.renounceMinter();
    }
}
