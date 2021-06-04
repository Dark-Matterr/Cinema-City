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
    if(isset($_POST["voidTicket"])){
        $ticket_id = mysqli_real_escape_string($conn, $_POST["ticket_id"]);
        $delete_query = "DELETE FROM cinema_reservation WHERE `ticket_id`='$ticket_id'";
		if(mysqli_query($conn, $delete_query)){
			echo ticketData($conn);
		}else{
            echo json_encode(0);
        }
    }

}
function ticketData($conn){
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

?>