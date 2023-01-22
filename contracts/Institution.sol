// This is the beginning of the solidity contract for the Institution.
pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

// Importing the Certification contract
import "./Certification.sol";

// Defining the contract structure for Institution
contract Institution {
    // State variable to store the address of the owner
    address public owner;

        // Mappings for storing institutes and courses
    mapping(address => Institute) private institutes; // Institutes Mapping
    mapping(address => Course[]) private instituteCourses; // Courses Mapping

    // Event for when a new institute is added
    event instituteAdded(string _instituteName);

    // Constructor function that sets the owner to the address of the contract creator
    constructor() public {
        owner = msg.sender;
    }

    // Structure for storing course information
    struct Course {
        string course_name;
        // Other attributes can be added
    }

    // Structure for storing institute information
    struct Institute {
        string institute_name;
        string institute_acronym;
        string institute_link;
    }

// Function for converting a string to bytes32
function stringToBytes32(string memory source)
    private
    pure
    returns (bytes32 result)
{
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }
    assembly {
        result := mload(add(source, 32))
    }
}

// Function for adding a new institute
function addInstitute(
    address _address,
    string memory _institute_name,
    string memory _institute_acronym,
    string memory _institute_link,
    Course[] memory _institute_courses
    ) public returns (bool) {
    // Only owner can add institute
    require(
        msg.sender == owner,
        "Caller must be the owner - only owner can add an institute"
    );
    bytes memory tempEmptyStringNameTest = bytes(
        institutes[_address].institute_name
    );
    require(
        tempEmptyStringNameTest.length == 0,
        "Institute with token already exists"
    );
    require(
        _institute_courses.length > 0,
        "Atleast one course must be added"
    );
    institutes[_address] = Institute(
        _institute_name,
        _institute_acronym,
        _institute_link
    );
    for (uint256 i = 0; i < _institute_courses.length; i++) {
        instituteCourses[_address].push(_institute_courses[i]);
    }
    emit instituteAdded(_institute_name);
}

   // Function for retrieving institute data, called by institutions
   function getInstituteData()
        public
        view
        returns (
        string memory,
        string memory,
        string memory,
        Course[] memory
        )
    {
        // Retrieving the institute data for the calling address
        Institute memory temp = institutes[msg.sender];
        // Checking if the institute exists
        bytes memory tempEmptyStringNameTest = bytes(temp.institute_name);
        require(
            tempEmptyStringNameTest.length > 0,
            "Institute account does not exist!"
        );
        // Returning the institute data
        return (
            temp.institute_name,
            temp.institute_acronym,
            temp.institute_link,
            instituteCourses[msg.sender]
        );
    }

   // Function for retrieving institute data, called by smart contracts
    function getInstituteData(address _address)
    public
    view
    returns (
        string memory,
        string memory,
        string memory,
        Course[] memory
    )
    {
        // Checking if the smart contract calling the function is authorized
        require(Certification(msg.sender).owner() == owner, "Incorrect smart contract & authorizations!");
        // Retrieving the institute data for the provided address
        Institute memory temp = institutes[_address];
        // Checking if the institute exists
        bytes memory tempEmptyStringNameTest = bytes(temp.institute_name);
        require(
            tempEmptyStringNameTest.length > 0,
            "Institute does not exist!"
        );
        // Returning the institute data
        return (
            temp.institute_name,
            temp.institute_acronym,
            temp.institute_link,
            instituteCourses[_address]
        );
    }


    // Function for checking if an institute exists
    function checkInstitutePermission(address _address)
        public
        view
        returns (bool)
   {
        // Retrieving the institute data for the provided address
        Institute memory temp = institutes[_address];
        // Checking if the institute exists
        bytes memory tempEmptyStringNameTest = bytes(temp.institute_name);
        if (tempEmptyStringNameTest.length > 0) {
            // If the institute exists, return true
            return true;
        } 
        else {
            // If the institute does not exist, return false
            return false;
        }
    }
}
