$(document).ready(function(){
    
    
    $(document).on('click', '.void_ticket',function(event) {
        var ticket_id = $(this).attr("value");
        Swal.fire({
            title: 'Are you sure?',
            text: "Do you really want to void this ticket?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, void it!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    url: 'operations/delete_ticket.php',
                    data: {
                        ticket_id: ticket_id,
                        voidTicket: "true",
                    },
                    dataType: "text",
                    success: function(data){
                        if(data == "0"){
                            failedAlert();
                        } 
                        else{
                            $("#table_search").html(data);
                            Swal.fire('Voided!','This ticket is succesfully voided.','success');
                        }
                    }
                });
            }
        }) 
    });




});