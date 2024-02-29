pragma solidity 0.8.12;

contract GistPin {
  string public name = "GistPin";
  uint256 public videoCount = 0;
  uint256 public imageCount = 0;
  mapping(uint256 => Image) public images;
  mapping(uint256 => Video) public videos;

  struct Image {
    uint256 id;
    string hash;
    string description;
    uint256 tipAmount;
    address payable author;
  }

  struct Video {
    uint256 id;
    string hash;
    string title;
    address author;
  }

  event VideoUploaded(
    uint256 id,
    string hash,
    string title,
    string description,
    address author
  );

  constructor() {
    name = "GistPin";
  }

  function uploadVideo(
    string memory _videoHash,
    string memory _title,
    string memory _description
  ) public {
    require(bytes(_videoHash).length > 0);
    require(bytes(_title).length > 0);
    require(bytes(_description).length > 0);
    require(msg.sender != address(0));

    videoCount++;

    videos[videoCount] = Video(videoCount, _videoHash, _title, msg.sender);
    emit VideoUploaded(
        videoCount,
        _videoHash,
        _title,
        _description,
        msg.sender
    );
  }

  event ImageCreated(
    uint256 id,
    string hash,
    string description,
    uint256 tipAmount,
    address payable author
  );

  event ImageTipped(
    uint256 id,
    string hash,
    string description,
    uint256 tipAmount,
    address payable myAddress
  );

   function uploadImage(string memory _imgHash, string memory _description) public {
    require(bytes(_imgHash).length > 0);
    require(bytes(_description).length > 0);
    require(msg.sender!=address(0x0));

    imageCount ++;


    images[imageCount] = Image(imageCount, _imgHash, _description, 0, payable(msg.sender));

    emit ImageCreated(imageCount, _imgHash, _description, 0, payable(msg.sender));
  }

function tipImageOwner(uint _id) public payable {
    require(_id > 0 && _id <= imageCount);
    Image memory _image = images[_id];
    address payable _author = _image.author;
    _author.transfer(msg.value);
    _image.tipAmount = _image.tipAmount + msg.value;
    images[_id] = _image;
    emit ImageTipped(_id, _image.hash, _image.description, _image.tipAmount, payable(_author));
 }

}


