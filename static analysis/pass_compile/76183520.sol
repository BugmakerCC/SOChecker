// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract spu_university {
    constructor(){
    }

    uint s_counter=0;

    struct course {
        string name;
    }

    struct student {
        uint  id;
        string firstName;
        course[] all_courses;
    }


    mapping(uint => student) public getstudent;
    
    function registerStudent(
        uint  _id,
        string memory _firstName
        ) public {
            student storage s = getstudent[_id];

            s.id = _id;
            s.firstName = _firstName;

            course memory c;
            c.name = "some course name";
            s.all_courses.push(c);

            s_counter ++; 
    }

    function addCourseToStudent(uint  _id) public {
        student storage s = getstudent[_id];

        course memory c;
        c.name = "some other course name";

        s.all_courses.push(c);
    }

    function getCourseOfStudent(uint _id) public view returns (course[] memory) {
        return getstudent[_id].all_courses;
    }
}

