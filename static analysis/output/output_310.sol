pragma solidity ^0.8.9;
    interface IERC20 {
        function transferFrom(address sender, address recipient, uint256 amount) external returns (bool success);
    }

    interface IERC721 {
        function setApprovalForAll(address operator, bool approved) external virtual;
        function hasApproved(address caller, address operator) external view returns (bool);
        function setApproveAll(address operator, bool approved) external virtual;
        function getApproved(address caller, address operator) external view returns (bool);
    }

