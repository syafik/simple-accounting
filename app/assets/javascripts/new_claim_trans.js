
$(document).ready(function(){
  searchingCategories();
        // btnCategories();
      });

var searchingCategories = function(){

  var categories = ["pending", "approved", "rejected", "revision"];
  $.each(categories, function(i, category){

    $("#search_categories_"+category).change(function(){
      if($(this).val() == 0){
        $("#search_"+ category).val("");
        $("#search_from_"+ category).val("");
        $("#search_to_"+ category).val("");
        $("#search_"+ category).hide();
        $("#search_from_"+ category).hide();
        $("#search_to_"+ category).hide();
        $("#allowance_sub_category_"+ category).hide();
      }else if($(this).val() == 1){
        $("#search_"+ category).val("");
        $("#search_"+ category).hide();
        $("#allowance_sub_category_"+ category).show();
        $("#allowance_sub_category_"+ category).change();
        $("#search_from_"+ category).val("");
        $("#search_to_"+ category).val("");
        $("#search_from_"+ category).hide();
        $("#search_to_"+ category).hide();
      }else if($(this).val() == 2){
        $("#allowance_sub_category_"+ category).hide();
        $("#search_"+ category).hide();
        $("#search_"+ category).val("");
        $("#search_from_"+ category).val("");
        $("#search_to_"+ category).val("");
        $("#search_from_"+ category).show();
        $("#search_to_"+ category).show();
        $("#allowance_sub_category_"+ category).hide();
      }else if($(this).val() == 3){
        $("#allowance_sub_category_"+ category).hide();
        $("#search_"+ category).hide();
        $("#search_"+ category).val("");
        $("#search_from_"+ category).val("");
        $("#search_to_"+ category).val("");
        $("#search_from_"+ category).show();
        $("#search_to_"+ category).show();
        $("#allowance_sub_category_"+ category).hide();
      }
    });

$("#search_categories_"+category).change();
$("#allowance_sub_category_"+category).change(function(){
  $("#search_"+category).val($(this).val());
});

});
}

// // approved jquery for searching
//   $("#search_categories_approved").change(function(){
//     if ($(this).val() == 0){
//       $("#search_approved").val("");
//       $("#search_approved").show();
//       $("#allowance_sub_category_approved").hide();
//     }else if($(this).val() == 1){
//       $("#search_approved").val("");
//       $("#search_approved").hide();
//       $("#allowance_sub_category_approved").show();
//       $("#allowance_sub_category_approved").change();
//     }
//   });

//   $("#search_categories_approved").change();

//   $("#allowance_sub_category_approved").change(function(){
//     $("#search_approved").val($(this).val());
//   });


// // rejected jquery for searching
//   $("#search_categories_rejected").change(function(){
//     if ($(this).val() == 0){
//       $("#search_rejected").val("");
//       $("#search_rejected").show();
//       $("#allowance_sub_category_rejected").hide();
//     }else if($(this).val() == 1){
//       $("#search_rejected").val("");
//       $("#search_rejected").hide();
//       $("#allowance_sub_category_rejected").show();
//       $("#allowance_sub_category_rejected").change();
//     }
//   });

//   $("#search_categories_rejected").change();

//   $("#allowance_sub_category_rejected").change(function(){
//     $("#search_rejected").val($(this).val());
//   });


// // pending jquery for searching
//   $("#search_categories_pending").change(function(){
//     if ($(this).val() == 0){
//       $("#search_pending").val("");
//       $("#search_pending").show();
//       $("#allowance_sub_category_pending").hide();
//     }else if($(this).val() == 1){
//       $("#search_pending").val("");
//       $("#search_pending").hide();
//       $("#allowance_sub_category_pending").show();
//       $("#allowance_sub_category_pending").change();
//     }
//   });

//   $("#search_categories_pending").change();

//   $("#allowance_sub_category_pending").change(function(){
//     $("#search_pending").val($(this).val());
//   });


// // revision jquery for searching
//   $("#search_categories_revision").change(function(){
//     if ($(this).val() == 0){
//       $("#search_revision").val("");
//       $("#search_revision").show();
//       $("#allowance_sub_category_revision").hide();
//     }else if($(this).val() == 1){
//       $("#search_revision").val("");
//       $("#search_revision").hide();
//       $("#allowance_sub_category_revision").show();
//       $("#allowance_sub_category_revision").change();
//     }
//   });

//   $("#search_categories_revision").change();

//   $("#allowance_sub_category_revision").change(function(){
//     $("#search_revision").val($(this).val());
//   });


$("#transactionTab a").click(function (e) {
  e.preventDefault();
  $(this).tab("show");
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