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
    if(isset($_POST['statusToggle'])){
        $movie_id = trim(mysqli_real_escape_string($conn, $_POST['movie_id']));
        $current_stat = "SELECT movie_status FROM cinema_movies WHERE movie_id = '$movie_id'";
        $toggle = 0;
        $result = mysqli_query($conn, $current_stat);
        while($row = mysqli_fetch_assoc($result)){
            if($row["movie_status"] == 1){
                $toggle = 0;
            }else{
                $toggle = 1;
            }
        }
        $update_query = "UPDATE cinema_movies SET movie_status = '$toggle' WHERE movie_id='$movie_id'";
        if(mysqli_query($conn, $update_query)){
            movieData($conn);
        }
    }

    if(isset($_POST['deleteMovie'])){
        $id = mysqli_real_escape_string($conn, $_POST["movie_id"]);
        $delete_query = "DELETE FROM cinema_movies WHERE `movie_id`='$id'";
		if(mysqli_query($conn, $delete_query)){
			movieData($conn);
		}else{
            echo json_encode(0);
        }
    }
}

function movieData($conn){
    $query = "SELECT * FROM cinema_movies";
    $result = mysqli_query($conn, $query);
    if (mysqli_num_rows($result) > 0) {
        while($row = mysqli_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td><img src='http://localhost/".$row['movie_image']."' width='70'></td>";
            echo "<td>".$row['movie_title']."</td>";
            echo "<td>".substr($row['movie_description'], 0, 200)."....</td>";
            echo "<td>".$row['movie_genre']."</td>";
            echo ($row['movie_status'] == "1") ? "<td><button class='btn btn-warning status_toggle' value='".$row['movie_id']."'>On</button></td>" : "<td><button class='btn btn-secondary status_toggle' value='".$row['movie_id']."'>Off</button></td>";
            echo "<td><a href='edit_movie.php?id=".$row['movie_id']."' class='btn btn-info'>Edit</a></td>";
            echo "<td><button class='btn btn-danger delete_movie' value='".$row['movie_id']."'>Delete</button></td>";
            echo "</tr>";
        }
    
    }
}
?>