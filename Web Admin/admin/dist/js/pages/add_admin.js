$("document").ready(function(){
    
    $("#add_adminbtn").click(function(){
        var email = $("#email").val().trim();
        var pass = $("#pass").val().trim();
        var retpass = $("#retpass").val().trim();
        var fname = $("#fname").val().trim();
        var lname = $("#lname").val().trim();
        if(email != "" && pass != "" && retpass != "" && fname != "" && lname != ""){   
            if(pass === retpass && validateEmail(email)){
                $.ajax({
                    type: "POST",
                    url: 'operations/admin.php',
                        data: {
                            admin_email: email,
                            admin_fname: fname,
                            admin_lname: lname,
                            admin_pass: pass,
                            addAdmin: "true",
                            },
                            dataType: "text",
                            success: function(data)
                            {
                                if(data == "0"){
                                    failedAlert();
                                } 
                                else{
                                    successAlert();
                                    $("#table_admin").html(data);
                                    $("input").val("");
                                }
                            }
                    });
            }else{
                validationForm();   
            }
        }else{
            emptyAlert();
        }
    });

    //Delting admin user account
    $(document).on('click', '.remove_btn',function(event) {
        var admin_id = $(this).attr("value");
        Swal.fire({
            title: 'Are you sure?',
            text: "Do you really want to delete this admin user?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    url: 'operations/admin.php',
                    data: {
                        admin_id: admin_id,
                        deleteAdmin: "true",
                    },
                    dataType: "text",
                    success: function(data){
                        if(data == "0"){
                            failedAlert();
                        } 
                        else{
                            $("#table_admin").html(data);
                            Swal.fire('Deleted!','This admin user is succesfully deleted.','success')   
                        }
                    }
                });
            }
        }) 
    });
   


   function successAlert(){
    Swal.fire({
        title: 'New Admin Successfully Added ',
        text: "Please test the account first",
        icon: 'success',
        showCancelButton: false,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Okay, Master!',
    });
   }

   function failedAlert(){
    Swal.fire({
        title: 'Email is Already Exist',
        text: "Try to use that email or add different email account",
        icon: 'error',
        showCancelButton: false,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Okay, Master!',
    });
   }

   function emptyAlert(){
    Swal.fire({
        title: 'Fill Up All Inputs',
        text: "Check your inputs and don't leave blank data",
        icon: 'warning',
        showCancelButton: false,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Okay, Master!',
    });
   }
   function validationForm(){
    Swal.fire({
        title: 'Error in Email Address or Password',
        text: "Please retype again the password that you inputted or recheck your inputted email address",
        icon: 'warning',
        showCancelButton: false,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Okay, Master!',
    });
   }

   function validateEmail(email) {
    const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  }
  
});