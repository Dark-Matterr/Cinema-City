$(document).ready(function(){
    $(document).on('click', '.status_toggle',function(event) {
        var movie_id = $(this).attr("value");
        $.ajax({
            type: "POST",
            url: 'operations/movies.php',
            data: {
                movie_id : movie_id,
                statusToggle : "True",
            },
            dataType: "text",
            success: function(data){
                $("#movie_table").html(data);
                successAlert();
            }
        });
    });

    $(document).on('click', '.delete_movie',function(event) {
        var movie_id = $(this).attr("value");
        Swal.fire({
            title: 'Are you sure?',
            text: "Do you really want to delete this movie?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    url: 'operations/movies.php',
                    data: {
                        movie_id: movie_id,
                        deleteMovie: "true",
                    },
                    dataType: "text",
                    success: function(data){
                        if(data == "0"){
                            failedAlert();
                        } 
                        else{
                            $("#movie_table").html(data);
                            Swal.fire('Deleted!','This movie is succesfully deleted.','success');
                        }
                    }
                });
            }
        }) 
    });


    function successAlert(){
        Swal.fire({
            title: 'The Movie Status Has Been Change',
            text: "Toggle again if this is accidentally press",
            icon: 'success',
            showCancelButton: false,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Okay, Master!',
        });
       }

    function failedAlert(){
        Swal.fire({
            title: 'Error in Deleting Movie',
            text: "Please try again later",
            icon: 'error',
            showCancelButton: false,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Okay, Master!',
        });
       }  
});