Reader[] public readers;

readers.push(Reader("Freddie", 0, books[0]));

contract CoolSchool {
    mapping(string => string) public books; 
    mapping(string => string[]) public readers; 

    constructor() {
        _loadBooks();
    }

    function addBook(string memory isbn, string memory title) public {
        require(!_isEmpty(isbn), "isbn is required");
        require(!_isEmpty(title), "title is required");
        books[isbn] = title;
    }

    function addReadBook(string memory reader, string memory isbn) public {
        string[] storage read = readers[reader];
        require(!_isEmpty(books[isbn]), "unknown book");
        read.push(isbn);
    }

    function _loadBooks() private {
        books["0333791037"] = "The Great Gatsby";
        books["0684833395"] = "Catch-22";
        books["9780451524935"] = "1984";
    }

    function _isEmpty(string memory s) private pure returns (bool) {
        return bytes(s).length == 0;
    }
}


