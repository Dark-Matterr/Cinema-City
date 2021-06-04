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
  // get all reservation ticket
  $query = "SELECT cinema_movies.movie_title as title, SUM(cinema_reservation.price) AS total, SUM(LENGTH(seat_num) - LENGTH(REPLACE(seat_num, ',', ''))+1) AS seat FROM cinema_reservation  JOIN cinema_movies ON cinema_reservation.movie_id = cinema_movies.movie_id  WHERE cinema_movies.movie_status='1' GROUP BY cinema_reservation.movie_id";
  $result = mysqli_query($conn, $query);
  $total = '';
  $label = '';
  $seat = '';
  while($row = mysqli_fetch_array($result)){
    $label = $label."\"". $row['title']."\"".',';
    $total = $total."". $row['total']."".',';
    $seat = $seat."". $row['seat']."".',';
  }
  $total = trim($total, ",");
  $label = trim($label, ",");
  $seat = trim($seat, ",");
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
          <div class="col-sm-6">
            <h1 class="m-0">Dashboard</h1>
          </div>
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
        <div class="row">
          <div class="col-lg-4 col-6">
            <!-- small box -->
            <div class="small-box bg-info">
              <div class="inner">
                <h3>
                <?php 
                  $result=mysqli_query($conn, "SELECT count(*) as total from cinema_movies WHERE movie_status = '1'");
                  $data=mysqli_fetch_assoc($result);
                  echo $data['total'];
                ?>
                </h3>
                <p>Now Showing</p>
              </div>
              <div class="icon">
                <i class="ion ion-ios-film"></i>
              </div>
              <div class="small-box-footer">&nbsp;</div>
            </div>
          </div>
          <div class="col-lg-4 col-6">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
                <h3>
                <?php 
                  $result=mysqli_query($conn, "SELECT count(*) as total from cinema_customer");
                  $data=mysqli_fetch_assoc($result);
                  echo $data['total'];
                ?>
                </h3>
                <p>Customer Registrations</p>
              </div>
              <div class="icon">
                <i class="ion ion-person"></i>
                
              </div>
              <div class="small-box-footer">&nbsp;</div>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-4 col-6">
            <!-- small box -->
            <div class="small-box bg-danger">
              <div class="inner">
                <h3>
                <?php 
                  $result=mysqli_query($conn, "SELECT count(*) as total from cinema_reservation");
                  $data=mysqli_fetch_assoc($result);
                  echo $data['total'];
                ?>
                </h3>
                <p>Purchase Orders</p>
              </div>
              <div class="icon">
                <i class="ion ion-pie-graph"></i>
              </div>
              <div class="small-box-footer">&nbsp;</div>
            </div>
          </div>
          <!-- ./col -->
        </div>
        <!-- /.row -->
        <!-- Main row -->
        <div class="row col-sm-12">
          <div class="col-xl-8 card p-2">
              <div class="row d-flex justify-content-between ml-1 mr-1 nav nav-tabs pull-right ui-sortable-handle p-2">
                <h5><i class="fa fa-inbox"></i> Ticket Sales</h5>
                <?php 
                  $result=mysqli_query($conn, "SELECT SUM(cinema_reservation.price) AS total FROM cinema_reservation  JOIN cinema_movies ON cinema_reservation.movie_id = cinema_movies.movie_id  WHERE cinema_movies.movie_status='1'");
                  $data=mysqli_fetch_assoc($result);
                  if($data['total'] != null ){
                    echo "<h5><b>PHP ".$data['total']."</b></h5>";
                  }
               ?>
              </div>
              <canvas id="movieRank"></canvas>     
          </div>
          <div class="col-xl-4 card p-2">
              <div class="row d-flex justify-content-between ml-1 mr-1 nav nav-tabs pull-right ui-sortable-handle p-2">
                <h5><i class="fa fa-inbox"></i> Ticket Sold</h5></li>
                <h5><b>  
                <?php 
                  $result=mysqli_query($conn, "SELECT SUM(LENGTH(seat_num) - LENGTH(REPLACE(seat_num, ',', ''))+1) AS total FROM cinema_reservation  JOIN cinema_movies ON cinema_reservation.movie_id = cinema_movies.movie_id  WHERE cinema_movies.movie_status='1'");
                  $data=mysqli_fetch_assoc($result);
                  if($data['total'] != null ){
                    echo "<h5><b>".$data['total']." Tickets</b></h5>";
                  }
                ?> 
              </div>
              
              <canvas id="ticketCount" height="300"></canvas>
          </div> 
        </div>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>


  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<script src="dist/js/chart.js"></script>
<script src="dist/js/adminlte.js"></script>
<!-- Chart JS -->
<script>
  $(document).ready(function(){
    var movieRank = $("#movieRank");
    var ticketCount = $("#ticketCount");
   //Bar Chart
    var barchart = new Chart(movieRank, {
        type: 'bar',
        data: {
            labels: [<?php echo $label; ?>],
            datasets:[{
                label: ['Total Money Accumaleted Per Movie'],
                data: [<?php echo $total ?>],
                backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 2,
            }]

        },
        option: {
        maintainAspectRatio: true,
        responsive: true
    }
    });

    //Pie chart
    var piechart = new Chart(ticketCount, {
    type: 'doughnut',
    data: {
        labels: [<?php echo $label; ?>],
        datasets:[{
            label: 'Category',
            data:  [<?php echo $seat; ?>],
            backgroundColor: ["rgba(255, 99, 132, 1)", "rgba(126,234,223)", "rgba(106,206,150)", "rgba(255,210,77)"]
        }]
    }
});

});
</script>
</body>
</html>
<?php }else{header("Location: login.php");} ?>