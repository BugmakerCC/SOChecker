pragma solidity ^0.8.9;
contract ExperienceContract {
    struct Experience {
        string jobTitle;
        string company;
        uint256 startDate;
        uint256 endDate;
    }

    mapping(address => Experience) experiencesSingle;
    mapping(address => Experience[]) experiencesMultiple;

    function addSingleExperience(
        address _address,
        string memory _jobTitle,
        string memory _company,
        uint256 _startDate,
        uint256 _endDate
    ) public {
        experiencesSingle[_address] = Experience(_jobTitle, _company, _startDate, _endDate);
    }

    function addMultipleExperience(
        address _address,
        string memory _jobTitle,
        string memory _company,
        uint256 _startDate,
        uint256 _endDate
    ) public {
        experiencesMultiple[_address].push(Experience(_jobTitle, _company, _startDate, _endDate));
    }

    function getSingleExperience(address _address) public view returns (string memory, string memory, uint256, uint256) {
        Experience memory exp = experiencesSingle[_address];
        return (exp.jobTitle, exp.company, exp.startDate, exp.endDate);
    }

    function getMultipleExperience(address _address) public view returns (Experience[] memory) {
        return experiencesMultiple[_address];
    }
}

