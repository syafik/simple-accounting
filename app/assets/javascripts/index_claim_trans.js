$(document).ready(function(){
				searchingCategories();
				btnCategories();
 });

var searchingCategories = function(){
		var categories =["pending","approved","rejected","revision"];
		$.each(categories, function( i, category){
			$("#search_categories_"+ category).change(function(){
			if($(this).val() == 0){
				$("#search_"+ category).val("");
				$("#from_"+ category).val("");
				$("#to_"+ category).val("");
				$("#search_"+ category).hide();
				$("#from_"+ category).hide();
				$("#to_"+ category).hide();
				$("#allowance_sub_category_"+ category).hide();
			}else if ($(this).val() == 1){
				$("#search_"+ category).val("");
				$("#search_"+ category).show();
				$("#from_"+ category).val("");
				$("#to_"+ category).val("");
				$("#allowance_sub_category_"+ category).hide();
				$("#from_"+ category).hide();
				$("#to_"+ category).hide();
			}else if($(this).val() == 2){
				$("#search_"+ category).val("");
				$("#search_"+ category).hide();
				$("#allowance_sub_category_"+ category).show();
				$("#allowance_sub_category_"+ category).change();
				$("#from_"+ category).val("");
				$("#to_"+ category).val("");
				$("#from_"+ category).hide();
				$("#to_"+ category).hide();
			}else if($(this).val() == 3){
				$("#allowance_sub_category_"+ category).hide();
				$("#search_"+ category).hide();
				$("#search_"+ category).val("");
				$("#from_"+ category).val("");
				$("#to_"+ category).val("");
				$("#from_"+ category).show();
				$("#to_"+ category).show();
				$("#allowance_sub_category_"+ category).hide();
			}else if($(this).val() == 4){
				$("#allowance_sub_category_"+ category).hide();
				$("#search_"+ category).hide();
				$("#search_"+ category).val("");
				$("#from_"+ category).val("");
				$("#to_"+ category).val("");
				$("#from_"+ category).show();
				$("#to_"+ category).show();
				$("#allowance_sub_category_"+ category).hide();
			}
		});

	$("#search_categories_"+ category).change();

		$("#allowance_sub_category_"+ category).change(function(){
			$("#search_"+ category).val($(this).val());
		});
		})
}

var btnCategories = function(){
	var categories = ["reject","approve","revision"];
	$.each(categories, function(i, category){
		$("#"+category+"reject_btn").click(function(){
			$("#decision").val("rejected");
		});
	});
}





$('#myTab a').click(function (e) {
e.preventDefault();
$(this).tab('show');
})

$('#will_paginate_id').bind('click', function(event){
	window.scrollTo(0,0);
	// Some code to show loader on screen
	$('#loading').html('<div class="ui active dimmer"><div class="ui large text loader">Loading</div></div>');
});



$(function() {
		$( ".from-date" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				numberOfMonths: 3,
				onClose: function( selectedDate ) {
						$( "#to" ).datepicker( "option", "minDate", selectedDate );
				}
		});
		$( ".to-date" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				numberOfMonths: 3,
				onClose: function( selectedDate ) {
						$( "#from" ).datepicker( "option", "maxDate", selectedDate );
				}
		});
});