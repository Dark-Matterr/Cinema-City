<?php
 session_start();
 if(isset($_SESSION['auth']) == true){
   include_once('includes/db/connection.php');
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

function addMovie($image, $title, $director, $cast, $desc, $genre, $price, $connection){
    $img_dir = "cinema/images/" . basename($image["name"]);
    $insert_query = "INSERT INTO cinema_movies(movie_image, movie_title, movie_director, movie_cast, movie_genre, movie_description,  movie_price, movie_status) VALUES('$img_dir', '$title', '$director', '$cast', '$genre', '$desc', $price, '0')";
    if (mysqli_query($connection, $insert_query)) {
       
    }
}

function imageUpload($image){
    $dir  = "../images/";
    $file = $dir . basename($image["name"]);
    $imageFileType = strtolower(pathinfo($file, PATHINFO_EXTENSION));
    $check = getimagesize($image["tmp_name"]);
    $uploadOk = 1;
    if($check !== false) {
      // file is an image
      $uploadOk = 1;
    } else {
      // file is not an image
      $uploadOk = 0;
    }
    // Check if file already exists
    if (file_exists($file)) {
        return 0;
    }

    // Allow certain file formats
    if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg") {
        return 0;
    }

    // Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        return 0;
    } else {
        if (move_uploaded_file($image["tmp_name"], $file)) {
            return 1;
        }
        // have an error in uploading file
        else {
           return 0;
        }
    }
    
}

?>
<!DOCTYPE html>
<html lang="en">
<?php include("includes/header.php"); ?>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>


  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"  href="logout.php" role="button">
          <i class="fas fa-sign-out-alt"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <?php include('includes/sidebar.php');?>
  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6 pl-2">
          <h1 class="m-0">New Movie</h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content pl-3">
      <div class="container-fluid">
        <!-- Main row -->
        <form action="add_movies.php" method="post" enctype="multipart/form-data">
        <div class="row p-2">
            <div class="form-group col-sm-12">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Movie Image</h6>
                    <input type="file" name="movie_image">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Title</h6>
                    <input type="text" id="function" class="form-control" name="movie_title" placeholder="Enter the Movie Title">
                </div>
            </div>
            <div class="form-group col-sm-4">
                <div class="col-sm-12 mb-1">
                    <h6 class="font-weight-normal">Director</h6>
                    <input type="text" id="function" class="form-control" name="movie_director" placeholder="Enter the Movie Director">
                </div>
            </div>
            <div class="form-group col-sm-8">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Movie Cast</h6>
                    <input type="text" id="function" class="form-control" name="movie_cast" placeholder="Enter the Movie Cast">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Sypnosis</h6>
                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="4" name="movie_desc"></textarea>
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Genre</h6>
                    <input type="text" id="function" class="form-control" name="movie_genre" placeholder="Enter the Move Genre">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Price</h6>
                    <input type="number" id="function" class="form-control" name="movie_price" placeholder="Enter the Move Price">
                </div>
            </div>
            <!--Button -->
            <div class="col-sm-12 mt-3">
                <input class="btn btn-lg btn-success col-sm-12 mb-5" type="submit" value="Add Movie" name="addmovie">
            </div>
        </div>
        </form>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
</div>
<!-- ./wrapper -->



<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<script src="dist/js/adminlte.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<?php
   if(isset($_POST['addmovie'])){
    $image = $_FILES["movie_image"];
    $title = trim(mysqli_real_escape_string($conn, $_POST['movie_title']));
    $director = trim(mysqli_real_escape_string($conn, $_POST['movie_director']));
    $cast = trim(mysqli_real_escape_string($conn, $_POST['movie_cast']));
    $desc = trim(mysqli_real_escape_string($conn, $_POST['movie_desc']));
    $genre = trim(mysqli_real_escape_string($conn, $_POST['movie_genre']));
    $price = trim(mysqli_real_escape_string($conn, $_POST['movie_price']));
     if($title != "" && $director != "" && $cast != "" && $desc != "" &&  $genre != "" && $price != ""){
      
      if(imageUpload($image, $conn)){
          echo addMovie($image, $title, $director, $cast, $desc, $genre, $price, $conn);
          echo "<script> 
          Swal.fire({
            title: 'New Movie Successfully Added ',
            text: 'Please add the schedule first before powering on the movie',
            icon: 'success',
            showCancelButton: false,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Okay, Master!',
        });</script>";
      }else{
        echo "
        <script> 
        Swal.fire({
          title: 'Error in Uploading Images or Input Forms',
          text: 'Recheck your inputs and file name',
          icon: 'error',
          showCancelButton: false,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Okay, Master!',
      });</script>";
      }
    }
    else{
      echo "
        <script> 
        Swal.fire({
          title: 'Fill Up All Inputs',
          text: 'Check your inputs and don\'t leave blank data',
          icon: 'warning',
          showCancelButton: false,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Okay, Master!',
      });</script>";
    }
  }

?>

</body>
</html>
<?php }else{header("Location: login.php");} ?>