[StructObject].[Attribute];

function getInfo(uint _infoid) external view returns (uint, address) {
  return (infos[_infoid]._id, infos[_infoid]._add);
}


