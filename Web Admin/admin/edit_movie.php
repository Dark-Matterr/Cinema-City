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

  <?php
        if($_GET["id"]){
          $movie_id = $_GET["id"];
          $sql_select = "SELECT * FROM `cinema_movies` WHERE `movie_id` =  '".mysqli_real_escape_string($conn,$movie_id)."'";
				  $run = mysqli_query($conn, $sql_select);
          if(mysqli_num_rows($run) == 1){ 
            while($edit = mysqli_fetch_assoc($run)){ 
          ?>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6 pl-2">
          <h1 class="h5"><b><?php echo $edit['movie_title'];?></b></h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content pl-3">
      <div class="container-fluid">
        <!-- Main row -->
        <form action="operations/edit_movie.php?id=<?php echo $_GET["id"]; ?>" method="post" enctype="multipart/form-data">
        <div class="row p-2">
        
            <div class="form-group col-sm-12">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Title</h6>
                    <input type="text" id="function" class="form-control" name="movie_title" placeholder="Enter the Movie Title" value="<?php echo $edit['movie_title'];?>">
                </div>
            </div>
            <div class="form-group col-sm-4">
                <div class="col-sm-12 mb-1">
                    <h6 class="font-weight-normal">Director</h6>
                    <input type="text" id="function" class="form-control" name="movie_director" placeholder="Enter the Movie Director" value="<?php echo $edit['movie_director'];?>">
                </div>
            </div>
            <div class="form-group col-sm-8">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Movie Cast</h6>
                    <input type="text" id="function" class="form-control" name="movie_cast" placeholder="Enter the Movie Cast" value="<?php echo $edit['movie_cast'];?>">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Sypnosis</h6>
                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="4" name="movie_desc" ><?php echo $edit['movie_description'];?></textarea>
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Genre</h6>
                    <input type="text" id="function" class="form-control" name="movie_genre" placeholder="Enter the Move Genre" value="<?php echo $edit['movie_genre'];?>">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Price</h6>
                    <input type="number" id="function" class="form-control" name="movie_price" placeholder="Enter the Move Price" value="<?php echo $edit['movie_price'];?>">
                </div>
            </div>
            <!--Button -->
            <div class="col-sm-12 mt-3">
                <input class="btn btn-lg btn-success col-sm-12 mb-5" type="submit" value="Edit Movie" name="editmovie">
            </div>
           
        </div>
        </form>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
    <?php }}} ?>
  </div>
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
</body>
</html>
<?php }else{header("Location: login.php");} ?>