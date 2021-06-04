<?php
   session_start();
   if(isset($_SESSION['auth']) == true){
     include_once('../includes/db/connection.php');
   if(isset($_SESSION['email']) && isset($_SESSION['password']) == true){
     $sel_sql = "SELECT * FROM cinema_admin WHERE admin_email = '$_SESSION[email]' AND admin_password = '".md5($_SESSION['password'])."'";
     if($run_sql = mysqli_query($conn, $sel_sql)){
       if(mysqli_num_rows($run_sql) != 1){
        if(session_destroy()){
          header('Location:login.php');	
        }
       }
     }
     }else{
       header('Location:login.php');
   }

   if(isset($_POST['addsched'])){
      $movie_id = $_POST["movie_id"];
      $movie_query = "SELECT * FROM cinema_movies WHERE movie_id = $movie_id";
      $movie_title = mysqli_fetch_assoc(mysqli_query($conn, $movie_query))['movie_title'];
      $sched_date = $_POST["sched_date"];
      $sched_start = $_POST["sched_start"];
      $sched_end = $_POST["sched_end"];
      if($sched_date != null && $sched_start != null && $sched_end != null){
        $datetime = strtotime($sched_date.' '.$sched_start);
        $sched_id = $movie_id.date('G', $datetime).date('Y', $datetime).date('j', $datetime);
        $insert_query = "INSERT INTO cinema_moviesched (sched_id, movie_id, movie_title, sched_date, sched_timestart, Sched_timeend) 
        VALUES($sched_id, '$movie_id', '$movie_title', '$sched_date', '$sched_start', '$sched_end')";
        if (mysqli_query($conn, $insert_query)) {
            scheduleTable($conn);
        } else {
            echo json_encode(0);
        }
      }
    }

    if(isset($_POST['deleteSched'])){
        $sched_id = mysqli_real_escape_string($conn, $_POST["sched_id"]);
        $delete_query = "DELETE FROM cinema_moviesched WHERE `sched_id`='$sched_id'";
        if(mysqli_query($conn, $delete_query)){
            scheduleTable($conn);
        }else{
          echo json_encode(0);
        }
    }
    }
    function scheduleTable($conn){
      $query = "SELECT * FROM cinema_moviesched JOIN cinema_movies ON cinema_moviesched.movie_id  = cinema_movies.movie_id WHERE cinema_movies.movie_status = '1' ORDER BY sched_date  ASC";
      $result = mysqli_query($conn, $query);
      if (mysqli_num_rows($result) > 0) {
          while($row = mysqli_fetch_assoc($result)) {
              echo "<tr>";
              echo "<td>".$row['sched_id']."</td>";
              echo "<td>".$row['movie_title']."</td>";
              echo "<td>".date("F j, Y", strtotime($row['sched_date']))."</td>";
              echo "<td>".date("g A", strtotime($row['sched_timestart']))." - ".date("g A", strtotime($row['sched_timeend']))."</td>";
              echo "<td><button class='btn btn-danger delete_btn' value='".$row['sched_id']."'>Delete</button></td>";
              echo "</tr>";
          }
      }
      }
?>