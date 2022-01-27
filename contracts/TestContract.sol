// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

struct MonthPrice {
    uint8 dayCount;
    uint256 sumPrice;
}

contract TestContract is Ownable, Pausable {
   
    address public tokenAddres;

    constructor(address _tokenAddress) {
        tokenAddres = _tokenAddress;
    }

    mapping(uint256 => uint256) dayPrice;

    mapping(uint256 => MonthPrice) monthPrices;

    function setPrice(uint256 _price) external onlyOwner whenNotPaused {
        uint32 today = getDay();
        dayPrice[today] = _price;
        uint8 month = getMonth();
        monthPrices[month].sumPrice.sum(_price) ;
        monthPrices[month].dayCount.sum(1);
    }

    function getPrice() external view returns (uint256) {
        uint32 day = getDay();
        return dayPrice[day];
    }

    function getMonthAvgPrice(uint8 _month)
        external
        view
        returns (uint256)
    {
        MonthPrice memory averagePrice = monthPrices[_month];
        if (averagePrice.price == 0) return 0;
        else return averagePrice.sumPrice.div(averagePrice.dayCount);
    }

    function getDay() internal view returns (uint32) {
        uint256 chainStartTime = block.timestamp;
        uint32 day = uint256(chainStartTime / 1 days);
        return day;
    }

    function getMonth() internal view returns (uint8) {
        uint256 chainStartTime = block.timestamp;
        uint8 month = uint8((chainStartTime / 1 days) % 365) / 30 + 1;
        return month;
    }
}
