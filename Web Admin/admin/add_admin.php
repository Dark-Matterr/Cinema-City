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
          <h1 class="m-0">Add New Admin</h1>
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
                <h6 class="font-weight-normal">Email Address</h6>
                    <input type="text" id="email" class="form-control" name="admin_email" placeholder="Enter Email Address">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                    <h6 class="font-weight-normal">First Name</h6>
                    <input type="text" id="fname" class="form-control" name="admin_fname" placeholder="Enter First Name">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Last Name</h6>
                    <input type="text" id="lname" class="form-control" name="admin_lname" placeholder="Enter Last Name">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Password</h6>
                    <input type="password" id="pass" class="form-control" name="admin_pass" placeholder="Enter Password">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <div class="col-sm-12 mb-1">
                <h6 class="font-weight-normal">Retype Password</h6>
                    <input type="password" id="retpass" class="form-control" name="admin_retpass" placeholder="Retype Again the Password">
                </div>
            </div>
            <!--Button -->
            <div class="col-sm-12 mt-3">
                <a class="btn btn-lg btn-success col-sm-12 mb-5" id="add_adminbtn"  name="addAdmin">Add New Admin</a>
            </div>
            
            <div class="col-sm-12">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th class=" text-center">Email Address</th>
                    <th class="text-center">First Name</th>
                    <th class="text-center">Last Name</th>
                    <th class="text-center">Remove</th>
                  </tr>
                </thead>
                <tbody id="table_admin">
                  <?php 
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
                  ?>
                </tbody>
              </table>
            </div>
        </div>
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
<script src="dist/js/pages/add_admin.js"></script>
</body>
</html>
<?php }else{header("Location: login.php");} ?>