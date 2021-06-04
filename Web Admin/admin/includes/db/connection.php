<?php
    define("host", "localhost");
    define("user", "ADD_DB_USER_HERE");
    define("pass", "ADD_DB_USER_PASS_HERE");
    define("db", "cinema_city");

    $conn = mysqli_connect(host, user, pass, db);

    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

?>