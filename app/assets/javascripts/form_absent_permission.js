$("#absent_permission_category").change(function(){
	if($(this).val()==1){
		$("#absent_permission_long").val("");
		$("#absent_permission_long").show();
		
		$("#absent_permission_end_date").val("");
		$("#absent_permission_end_date").hide();
		$("#end-date-space").hide();
	}else if($(this).val()==2){
		$("#absent_permission_long").val("");
		$("#absent_permission_long").hide();
		$("#end-date-space").show();
		$("#absent_permission_end_date").val("");
		$("#absent_permission_end_date").show();
		$(".absent-time").hide();
	}

});

$("#absent_permission_category").change();