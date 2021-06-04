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
  if(isset($_POST["addAdmin"])){
    $email = trim(mysqli_real_escape_string($conn, $_POST["admin_email"]));
    $fname = trim(mysqli_real_escape_string($conn, $_POST["admin_fname"]));
    $lname = trim(mysqli_real_escape_string($conn, $_POST["admin_lname"]));
    $password = md5(mysqli_real_escape_string($conn, $_POST["admin_pass"]));
    if($email != null && $fname != null && $lname != null && $password != null){
      $check_query = "SELECT * FROM cinema_admin where admin_email = '$email'";
      $query = "INSERT INTO cinema_admin(admin_email, admin_fname, admin_lname, admin_password) VALUES ('$email', '$fname', '$lname', '$password')";
      if(mysqli_num_rows(mysqli_query($conn,$check_query)) == 0){
        if (mysqli_query($conn, $query)) {
          adminData($conn);
        }
      }else{
        echo json_encode(0);
      }
    }
  }


  if(isset($_POST["deleteAdmin"])){
    $admin_id = mysqli_real_escape_string($conn, $_POST["admin_id"]);
    $delete_query = "DELETE FROM cinema_admin WHERE `admin_id`='$admin_id'";
    if(mysqli_query($conn, $delete_query)){
      adminData($conn);
		}else{
      echo json_encode(0);
    }
  }
  }
  function adminData($conn){
    $query = "SELECT * FROM cinema_admin WHERE admin_id != '1'";
    $result = mysqli_query($conn, $query);
    if (mysqli_num_rows($result) > 0) {
        while($row = mysqli_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td>".$row['admin_email']."</td>";
            echo "<td>".$row['admin_fname']."</td>";
            echo "<td>".$row['admin_lname']."</td>";
            echo "<td><button class='btn btn-danger col-sm-12 remove_btn' value='".$row['admin_id']."'>Remove</button></td>";
            echo "</tr>";
        }
    }
    }
?>