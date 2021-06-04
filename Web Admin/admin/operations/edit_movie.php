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
  if(isset($_POST["editmovie"])){
    $title = mysqli_real_escape_string($conn, $_POST["movie_title"]);
    $director = mysqli_real_escape_string($conn, $_POST["movie_director"]);
    $cast = mysqli_real_escape_string($conn, $_POST["movie_cast"]);
    $sypnosis = mysqli_real_escape_string($conn, $_POST["movie_desc"]);
    $genre = mysqli_real_escape_string($conn, $_POST["movie_genre"]);
    $price = mysqli_real_escape_string($conn, $_POST["movie_price"]);
    $movie_id = mysqli_real_escape_string($conn, $_GET["id"]);
    if($title != null && $director != null && $cast != null && $sypnosis != null && $genre != null && $price != null){
      $query = "UPDATE cinema_movies SET movie_title='$title', movie_director='$director', movie_cast='$cast', movie_genre='$genre', movie_description='$sypnosis', movie_price='$price' WHERE movie_id='$movie_id'";;
      if (mysqli_query($conn, $query)) {  
        header("Location: ../movies.php");
      } else {
        echo "Error in updating the data";
      }
    }
  }
}
?>