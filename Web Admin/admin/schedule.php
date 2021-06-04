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

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6 pl-2">
          <h1 class="m-0">Schedule</h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content pl-3">
      <div class="container-fluid">
        <!-- Main row -->
        <div class="row p-2">
            <div class="form-group col-sm-12">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Movie</h6>
                <select id="movie_id" class="form-control form-control-md">
                    <?php
                        $sql = "SELECT * FROM cinema_movies WHERE movie_status = '1'";
                        $result = mysqli_query($conn, $sql);
                        if (mysqli_num_rows($result) > 0) {
                            // output data of each row
                            while($row = mysqli_fetch_assoc($result)) {
                              echo '<option value="'.$row['movie_id'].'">'.$row['movie_title'].'</option>';
                            }
                          }
                    ?>
                </select>
                </div>
            </div>
            <div class="form-group col-sm-4">
                <div class="col-sm-12 mb-1">
                    <h6 class="font-weight-normal">Schedule Date</h6>
                    <input type="date" class="form-control form-control-md" id="sched_date">
                </div>
            </div>
            <div class="form-group col-sm-4">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Starting Time</h6>
                    <input class="form-control" type="time" id="sched_start">
                </div>
            </div>
            <div class="form-group col-sm-4">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Ending Time</h6>
                    <input class="form-control" type="time"  id="sched_end">
                </div>
            </div>
            <!--Button -->
            <div class="col-sm-12 mt-3">
                <a class="btn btn-lg btn-success col-sm-12 mb-5" id="addsched">Add Schedule</a>
            </div>
        </div>

        <div class="pl-2">
          <table class="table">
            <thead>
              <tr>
                <th scope="col">ID</th>
                <th scope="col">Movie Title</th>
                <th scope="col">Date</th>
                <th scope="col">Time Slot</th>
                <th scope="col">Delete</th>
              </tr>
            </thead>
            <tbody id="table_sched">
              <?php
              $query = "SELECT * FROM cinema_moviesched JOIN cinema_movies ON cinema_moviesched.movie_id  = cinema_movies.movie_id WHERE cinema_movies.movie_status = '1' AND CONVERT(CONCAT(CAST(sched_date as DATE),' ',CAST(sched_timestart as TIME)), DATETIME) >= SYSDATE()  ORDER BY sched_date  ASC";
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
              ?>
            </tbody>
          </table>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->



<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<script src="dist/js/adminlte.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="dist/js/pages/schedule.js"></script>
</body>
</html>
<?php }else{header("Location: login.php");} ?>