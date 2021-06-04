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
    if(isset($_POST["search"]) && $_POST["search"] != null){
    $query = "SELECT * FROM cinema_reservation WHERE ticket_id LIKE '%". mysqli_real_escape_string($conn,$_POST["search"]) ."%'";
    $result = mysqli_query($conn, $query);
    if (mysqli_num_rows($result) > 0) {
        while($row = mysqli_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td>".$row['ticket_id']."</td>";
            echo "<td>".$row['sched_id']."</td>";
            echo "<td>".$row['customer_name']."</td>";
            echo "<td>".$row['customer_id']."</td>";
            echo "<td>".$row['movie_title']."</td>";
            echo "<td>".$row['seat_num']."</td>";
            echo "<td>".date('g A',strtotime($row['sched_timestart']))."</td>";
            echo "<td><button value='".$row['ticket_id']."' class='btn btn-danger void_ticket'>Void</button></td>";
            echo "</tr>";
          }
    
    }else{
        echo "<td>Ticket ID not found</td>";
        
    }
}else{
    $query = "SELECT * FROM cinema_reservation";
    $result = mysqli_query($conn, $query);
    if (mysqli_num_rows($result) > 0) {
        while($row = mysqli_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td>".$row['ticket_id']."</td>";
            echo "<td>".$row['sched_id']."</td>";
            echo "<td>".$row['customer_name']."</td>";
            echo "<td>".$row['customer_id']."</td>";
            echo "<td>".$row['movie_title']."</td>";
            echo "<td>".$row['seat_num']."</td>";
            echo "<td>".date('g A',strtotime($row['sched_timestart']))."</td>";
            echo "<td><button value='".$row['ticket_id']."' class='btn btn-danger void_ticket'>Void</button></td>";
            echo "</tr>";
          }
        }
}
    }
?>