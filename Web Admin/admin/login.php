<?php
	session_start();
	include_once('includes/db/connection.php');
	if(isset($_POST['login']) && $_SERVER['REQUEST_METHOD'] == 'POST'){
		if(!empty($_POST['admin_email']) && !empty($_POST['admin_pass'])){
			$email = mysqli_real_escape_string($conn, $_POST['admin_email']);
			$password = mysqli_real_escape_string($conn, $_POST['admin_pass']);
			$query = "SELECT * FROM `cinema_admin` WHERE `admin_email` = '$email' AND `admin_password`='".md5($password)."'";
			if ($result = mysqli_query($conn, $query)) {

				if (mysqli_num_rows($result) == 1) {
					$_SESSION['auth'] = "".uniqid()."";
                    while($row = mysqli_fetch_array($result)){
                    $_SESSION['fullname'] = $row["admin_fname"]." ".$row["admin_lname"];
                    }
					$_SESSION['email'] = $email;
					$_SESSION['password'] = $password;
					header('Location:index.php');
				}else{
					header('Location: login.php?code=invalid');
				}
			}else{
				header('Location: login.php?code=query_error');
			}
		}else{
			header('Location: login.php?code=empty');
		}
	}else{

	}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Cinema City Admin | Dashboard</title>
	<meta name="author" content="David Grzyb">
    <meta name="description" content="">

    <link href="https://unpkg.com/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .body-bg {
            background-color: #9921e8;
            background-image: linear-gradient(315deg, #9921e8 0%, #5f72be 74%);
        }
    </style>
</head>
<body class="body-bg min-h-screen pt-12 md:pt-20 pb-6 px-2 md:px-0" style="font-family:'Lato',sans-serif;">
    <header class="max-w-lg mx-auto">
        <a href="#">
            <h1 class="text-4xl font-bold text-white text-center text-danger">Cinema City Admin Panel</h1>
        </a>
    </header>

    <main class="bg-white max-w-lg mx-auto p-8 md:p-12 my-10 rounded-lg shadow-2xl">
        <section>
            <h3 class="font-bold text-2xl">Welcome to Cinema City</h3>
            <p class="text-gray-600 pt-2">Sign in to your admin account.</p>
        </section>

        <section class="mt-10">
            <form class="flex flex-col" method="POST" action="<?php echo $_SERVER['PHP_SELF'] ?>">
                <div class="mb-6 pt-3 rounded bg-gray-200">
                    <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="email">Email</label>
                    <input type="text" name="admin_email" id="email" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-purple-600 transition duration-500 px-3 pb-3">
                </div>
                <div class="mb-6 pt-3 rounded bg-gray-200">
                    <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="password">Password</label>
                    <input type="password" name="admin_pass" id="password" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-purple-600 transition duration-500 px-3 pb-3">
                </div>
                <button class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 rounded shadow-lg hover:shadow-xl transition duration-200" type="submit" name="login">Sign In</button>
            </form>
        </section>
    </main>

    <footer class="max-w-lg mx-auto flex justify-center text-white">
        <h5>Developed by TeamSpectra</h5>
    </footer>
</body>
</html>