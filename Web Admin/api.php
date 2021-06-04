<?php
    require_once('admin/includes/db/connection.php');

    /* Manual By Dominic Antigua
    login = user login access
    register = user register access
    movies = select all movies with statuscode = 1
    moviesched = select * available schedule of movie in a specific movie
    seatoccupy =  get all occupied seats in a specfic time, day and movie
    reservation = insert data to cinema_reservation table
    history = get all the purchase history ticket
    changepass = change the customer password
    */

    //Check if the account exist
    if(isset($_POST["access"])){
        $request = $_POST["access"];

        // Login user Account (access=login)
        if($request == "login" && isset( $_POST["user_email"]) && isset( $_POST["user_pass"])){
        $user_email = mysqli_real_escape_string($conn, $_POST["user_email"]);
        $user_pass =  md5(mysqli_real_escape_string($conn, $_POST["user_pass"]));
        login($user_email, $user_pass, $conn);
        }

        // Register Customer Account (access=register)
        if($request == "register" && isset( $_POST["reg_email"]) && isset($_POST["reg_fname"]) && isset($_POST["reg_lname"]) && isset( $_POST["reg_pass"])){
            $reg_email =  mysqli_real_escape_string($conn, $_POST["reg_email"]);
            $reg_fname =  mysqli_real_escape_string($conn, $_POST["reg_fname"]);
            $reg_lname =  mysqli_real_escape_string($conn, $_POST["reg_lname"]);
            $reg_pass =  md5(mysqli_real_escape_string($conn, $_POST["reg_pass"]));
            register($reg_email, $reg_fname, $reg_lname, $reg_pass, $conn);
        }

        //Get all showing movies
        if($request == "movies"){
            getMovies($conn);
        }

        //Get all movie Schedule to a specific movie
        if($request == "moviesched" && isset( $_POST["movie_id"])){
            $movie_id = $_POST["movie_id"];
            getMovieSched($movie_id, $conn);
        }

        // Get all Occupied seats on a specific day and timeslot
        if($request == "seatoccupy" &&  isset($_POST["movie_id"]) && isset($_POST["reserve_year"]) && isset($_POST["reserve_time"])){
            $movie_id = $_POST["movie_id"];
            $reserve_year = $_POST["reserve_year"];
            $reserve_time = $_POST["reserve_time"];
            $reserve_day = $_POST["reserve_day"];
            getOccupySeats($movie_id, $reserve_year, $reserve_time, $reserve_day, $conn);
        }

        if($request == "reservation" && isset($_POST["ticket_id"]) && isset($_POST["customer_id"]) && isset($_POST["customer_name"]) && isset($_POST["movie_id"]) && isset($_POST["movie_title"]) && isset($_POST["sched_id"]) && isset($_POST["seat_num"]) && isset($_POST["sched_timestart"]) && isset($_POST["price"])){
            $ticket_id = $_POST["ticket_id"];
            $customer_id = $_POST["customer_id"];
            $customer_name =  mysqli_real_escape_string($conn, $_POST["customer_name"]);
            $movie_id = $_POST["movie_id"];
            $movie_title =  mysqli_real_escape_string($conn, $_POST["movie_title"]);
            $sched_id = $_POST["sched_id"];
            $seat_num = $_POST["seat_num"];
            $sched_timestart = $_POST["sched_timestart"];
            $price = (double) $_POST["price"];
            reservationSeats($ticket_id, $customer_id, $customer_name, $movie_id, $movie_title, $sched_id, $seat_num, $sched_timestart, $price, $conn);
        }

        if($request == "history" && isset($_POST["user_id"])){
            $user_id = $_POST["user_id"];
            getPurchaseHistory($user_id, $conn);  
        }

        if($request == "changepass" && isset($_POST["user_id"]) && isset($_POST["user_currentpass"]) && isset($_POST["user_email"])  && isset($_POST["user_newpass"])){
            $user_id = (int) $_POST["user_id"];
            $user_email =  mysqli_real_escape_string($conn, $_POST["user_email"]);
            $user_currentpass =  md5(mysqli_real_escape_string($conn, $_POST["user_currentpass"]));
            $user_newpass =  md5(mysqli_real_escape_string($conn, $_POST["user_newpass"]));
            changePassword($user_id, $user_email, $user_currentpass, $user_newpass, $conn);
        }
        
    }

    function login($email, $passw, $connection){
        $query = "SELECT customer_id, customer_email, customer_fname, customer_lname FROM cinema_customer where customer_email = '$email' AND customer_password = '$passw'";
        $exec = mysqli_query($connection, $query);

        if(mysqli_num_rows($exec) == 1){
            $rows = array();
            while($r = mysqli_fetch_assoc($exec)){
                $rows[] = $r;
            }
            echo json_encode($rows);
        }
        else{
            echo json_encode(0);
        }
        mysqli_close($connection);
    }

    function register($email, $fname, $lname, $passw, $connection){
        $check_query = "SELECT customer_email FROM cinema_customer where customer_email = '$email'";
        $insert_query = "INSERT INTO cinema_customer(customer_email, customer_fname, customer_lname, customer_password) VALUES ('$email', '$fname',  '$lname',  '$passw')";
        if(mysqli_num_rows(mysqli_query($connection,$check_query)) == 0){
            if (mysqli_query($connection, $insert_query)) {
                echo json_encode(1);
            } else {
                echo json_encode(-1);
            }
        }else{
            echo json_encode(0);
        }
        mysqli_close($connection);
    }

    function getMovies($connection){
        $query = "SELECT * FROM cinema_movies WHERE movie_id IN (SELECT movie_id FROM cinema_moviesched WHERE CONVERT(CONCAT(CAST(cinema_moviesched.sched_date as DATE),' ',CAST(cinema_moviesched.sched_timestart as TIME)), DATETIME) >= SYSDATE()) AND movie_status = '1'";
        $exec = mysqli_query($connection, $query);
        $rows = array();
        while($r = mysqli_fetch_assoc($exec)){
            $rows[] = $r;
        }
        echo json_encode($rows);
        mysqli_close($connection);
    }

    function getMovieSched($movie_id, $connection){
        $query = "SELECT * FROM cinema_moviesched where movie_id = '$movie_id' AND CONVERT(CONCAT(CAST(sched_date as DATE),' ',CAST(sched_timestart as TIME)), DATETIME) >= SYSDATE()";
        $exec = mysqli_query($connection, $query);
        $rows = array();
        while($r = mysqli_fetch_assoc($exec)){
            $rows[] = $r;
        }
        echo json_encode($rows);
        mysqli_close($connection);
    }

    function getOccupySeats($movie_id, $reserve_year, $reserve_time, $reserve_day, $connection){
        $sched = intval($movie_id . $reserve_time. $reserve_year . $reserve_day);
        
        $query = "SELECT seat_num FROM cinema_reservation where movie_id = '$movie_id' AND sched_id = '$sched'";
        $exec = mysqli_query($connection, $query);
        $rows = array();
        while($r = mysqli_fetch_assoc($exec)){
            $rows[] = $r["seat_num"];
        }
        echo json_encode($rows);
        mysqli_close($connection);
    }

    function reservationSeats($ticket_id, $customer_id, $customer_name, $movie_id, $movie_title, $sched_id, $seat_num, $sched_timestart, $price, $connection){
        $count_query=mysqli_query($connection, "SELECT COUNT(*) as total FROM cinema_reservation");
        $count_data = mysqli_fetch_assoc($count_query);
        $ticketId = $ticket_id.$count_data['total'];
        $insert_query = "INSERT INTO cinema_reservation(ticket_id, customer_id, customer_name, movie_id, movie_title, sched_id, seat_num, sched_timestart, price) VALUES ($ticketId, $customer_id,  '$customer_name',  $movie_id, '$movie_title', $sched_id, '$seat_num', '$sched_timestart', $price)";
        if (mysqli_query($connection, $insert_query)) {
            echo json_encode(1);
        } else {
            echo mysqli_error($connection);
        }
       
    }

    function getPurchaseHistory($user_id, $connection){
        $query = "SELECT cinema_reservation.ticket_id, cinema_reservation.customer_name, cinema_reservation.movie_title, cinema_reservation.seat_num, cinema_moviesched.sched_date, cinema_moviesched.sched_timestart, cinema_reservation.price, cinema_reservation.date_transact FROM cinema_reservation JOIN cinema_moviesched ON cinema_reservation.sched_id=cinema_moviesched.sched_id WHERE cinema_reservation.customer_id='$user_id' ORDER BY cinema_reservation.date_transact DESC"; 
        $exec = mysqli_query($connection, $query);
        $rows = array();
        while($r = mysqli_fetch_assoc($exec)){
            $rows[] = $r;
        }
        echo json_encode($rows);
        mysqli_close($connection);
    }

    function changePassword($id, $email, $currentpass, $newpass, $connection){
        $query = "SELECT * FROM cinema_customer WHERE customer_id = '$id' AND customer_email = '$email' AND customer_password = '$currentpass'";
        if ($result = mysqli_query($connection, $query)) {
            if (mysqli_num_rows($result) == 1) {
                $update_query = "UPDATE cinema_customer SET customer_password='$newpass' WHERE customer_id='$id' AND customer_email='$email'";
                if (mysqli_query($connection, $update_query)) {
                    echo json_encode(1);
                  } else {
                    echo json_encode(0);
                  }
            }else{
                echo json_encode(0);
            }
        }
    }
?>