$("document").ready(function(){
    $("#addsched").click(function(){
        var movie_id = $("#movie_id").val().trim();
        var sched_date = $("#sched_date").val().trim();
        var sched_start = $("#sched_start").val().trim();
        var sched_end = $("#sched_end").val().trim();
        if(movie_id != null && sched_date != null && sched_start != "" && sched_end != ""){
            $.ajax({
                type: "POST",
                url: 'operations/schedule.php',
                    data: {
                        movie_id: movie_id,
                        sched_date: sched_date,
                        sched_start: sched_start,
                        sched_end: sched_end,
                        addsched: "true",
                        },
                        dataType: "text",
                        success: function(data)
                        {
                           if(data == 0){
                                failedAlert();
                           }
                           else{
                               $("#table_sched").html(data);
                               successAlert();
                               $("input").val("");
                           }
                        }
                });
        }else{
            emptyAlert();
        }
    });

    $(document).on('click', '.delete_btn',function(event) {
        var sched_id = $(this).attr("value");
        Swal.fire({
            title: 'Are you sure?',
            text: "Do you really want to delete this schedule?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    url: 'operations/schedule.php',
                    data: {
                        sched_id: sched_id,
                        deleteSched: "true",
                    },
                    dataType: "text",
                    success: function(data){
                        if(data == "0"){
                            failedAlert();
                        } 
                        else{
                            $("#table_sched").html(data);
                            Swal.fire('Deleted!','This movie schedule is succesfully deleted.','success')   
                        }
                    }
                });
            }
        }) 
    });

    function successAlert(){
        Swal.fire({
            title: 'New Schedule Has Been Added',
            text: "Check the schedule in client side",
            icon: 'success',
            showCancelButton: false,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Okay, Master!',
        });
       }
    
    function failedAlert(){
        Swal.fire({
            title: 'Error in Adding New Schedule',
            text: "Please check the inputs and try again",
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

});