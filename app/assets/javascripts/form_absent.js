$("#absent_categories").change(function(){
	if($(this).val()==1){
		$("#absent_time_in").show();
		$("#absent_time_out").show();
	} else {
		$("#absent_time_in").val("");
		$("#absent_time_out").val("");
		$("#absent_time_in").hide();
		$("#absent_time_out").hide();
	}

});

$("#absent_categories").change();