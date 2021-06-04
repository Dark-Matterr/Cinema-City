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
        <div class="row mb-2 d-flex justify-content-between">
          <div class="col-sm-6 pl-2">
          <h1 class="m-0">Reservation Tickets</h1>
          </div><!-- /.col -->
          <div class="col-sm-3 form-group row">
          <div class="col-auto">
            <div class="input-group mb-2">
              <div class="input-group-prepend">
                <div class="input-group-text">Search</div>
            </div>
            <input type="number" class="form-control" id="search_id" placeholder="Ticket ID">
          </div>
          </div>
          </div>
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content pl-3">
      <div class="container-fluid">
        <!-- Main row -->
        <table class="table">
  <thead>
    <tr>
      <th scope="col">Ticked ID</th>
      <th scope="col">Sched ID</th>
      <th scope="col">Customer Name</th>
      <th scope="col">Customer ID</th>
      <th scope="col">Movie Title</th>
      <th scope="col">Seat #</th>
      <th scope="col">Time</th>
    </tr>
  </thead>
  <tbody id="table_search">
    <?php 
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
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="dist/js/adminlte.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="dist/js/pages/tickets.js"></script>

<script>
  $(document).ready(function(){
    $("#search_id").keyup(function(){
      var txt = $(this).val();
        $("#table_search").html('');
        $.ajax({
          url: "http://localhost/cinema/admin/operations/search.php",
          method: "post",
          data:{search:txt},
          dataType:"text",
          success:function(data){
            $("#table_search").html(data);
          }
        });
      
    });
  });
</script>
</body>
</html>
<?php }else{header("Location: login.php");} ?>