function foo(uint8 version) public {
    if (version == 1) {
    } else if (version == 2) {
    } else {
        revert();
    }
}

function fooYul(uint8 version) public {
    assembly {
        switch version
        case 1 {
        }
        case 2 {
        }
        default {
            revert(0, 0)
        }
    }
}


