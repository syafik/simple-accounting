
  $('#search_categories').change(function(){
    if($(this).val() == 0){
      $("#search").val("");
      $("#search").hide();
      $("#allowance_sub_category_id").hide();
    }else if($(this).val() == 1){
      $("#search").val("");
      $("#search").show();
      $("#allowance_sub_category_id").hide();
      $("#allowance_category_id").hide();
    }else if( $(this).val() == 3){
      $("#search").val("");
      $("#search").hide();
      $("#allowance_category_id").hide();
      $("#allowance_sub_category_id").show();
      $("#allowance_sub_category_id").change();
    }else if( $(this).val() == 2){
      $("#search").val("");
      $("#search").hide();
      $("#allowance_sub_category_id").hide();
      $("#allowance_category_id").show();
      $("#allowance_category_id").change();
    }
  });

  $('#search_categories').change();

  $("#allowance_sub_category_id").change(function(){
    $("#search").val($(this).val());
  });

  $("#allowance_category_id").change(function(){
    $("#search").val($(this).val());
  });
