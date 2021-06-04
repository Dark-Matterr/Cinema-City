  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index.php" class="brand-link text-center">
      <span class="brand-text font-weight-light text-danger"><b>Cinema City</b></span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="dist/img/profile.png" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block"><?php echo $_SESSION['fullname']; ?></a>
        </div>
      </div>  

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <a href="index.php" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="movies.php" class="nav-link">
              <i class="nav-icon fas fa-id-badge"></i>
              <p>
                Movies
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="tickets.php" class="nav-link">
              <i class="nav-icon fas fa-barcode"></i>
              <p>
                Tickets
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="schedule.php" class="nav-link">
              <i class="nav-icon fas fa-calendar"></i>
              <p>
                Schedule
              </p>
            </a>
          </li>
          <!-- Add Items -->
          <li class="nav-item ">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-plus-square "></i>
              <p>
                Add Item
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="add_movies.php" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Movie</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="add_admin.php" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Admin</p>
                </a>
              </li>
            </ul>
          </li>
          <!-- End of Add Items -->
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>