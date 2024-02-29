function slice(
  uint256 start,
  uint256 end,
  uint256[] memory proposals
) public pure returns (uint256[] memory) {
  uint256[] memory result;

  uint256 idx = 0;

  for (uint256 i = start; i < end; i++) {
      result[idx] = proposals[i];
      idx++;
  }

  return result;
}


