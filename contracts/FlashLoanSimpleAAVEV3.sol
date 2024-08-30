// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import "@aave/core-v3/contracts/interfaces/IPool.sol";

import "./utils/Withdrawable.sol";

contract FlashLoadSimpleAAVEV3 is FlashLoanSimpleReceiverBase, Withdrawable {
    constructor(
        IPoolAddressesProvider provider
    ) FlashLoanSimpleReceiverBase(provider) {}

    function falshloan(address asset, uint256 amount) external {
        POOL.flashLoanSimple(address(this), asset, amount, bytes(""), 0);
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool) {
        require(msg.sender == address(POOL), "Caller is not the pool");
        require(initiator == address(this), "Initiator is not this contract");

        /// flashloan logic start

        /// flashloan logic end

        IERC20(asset).transfer(msg.sender, amount + premium);
        return true;
    }
}
