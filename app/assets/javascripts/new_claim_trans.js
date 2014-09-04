// approved jquery for searching
  $("#search_categories_approved").change(function(){
    if ($(this).val() == 0){
      $("#search_approved").val("");
      $("#search_approved").show();
      $("#allowance_sub_category_approved").hide();
    }else if($(this).val() == 1){
      $("#search_approved").val("");
      $("#search_approved").hide();
      $("#allowance_sub_category_approved").show();
      $("#allowance_sub_category_approved").change();
    }
  });

  $("#search_categories_approved").change();

  $("#allowance_sub_category_approved").change(function(){
    $("#search_approved").val($(this).val());
  });


// rejected jquery for searching
  $("#search_categories_rejected").change(function(){
    if ($(this).val() == 0){
      $("#search_rejected").val("");
      $("#search_rejected").show();
      $("#allowance_sub_category_rejected").hide();
    }else if($(this).val() == 1){
      $("#search_rejected").val("");
      $("#search_rejected").hide();
      $("#allowance_sub_category_rejected").show();
      $("#allowance_sub_category_rejected").change();
    }
  });

  $("#search_categories_rejected").change();

  $("#allowance_sub_category_rejected").change(function(){
    $("#search_rejected").val($(this).val());
  });


// pending jquery for searching
  $("#search_categories_pending").change(function(){
    if ($(this).val() == 0){
      $("#search_pending").val("");
      $("#search_pending").show();
      $("#allowance_sub_category_pending").hide();
    }else if($(this).val() == 1){
      $("#search_pending").val("");
      $("#search_pending").hide();
      $("#allowance_sub_category_pending").show();
      $("#allowance_sub_category_pending").change();
    }
  });

  $("#search_categories_pending").change();

  $("#allowance_sub_category_pending").change(function(){
    $("#search_pending").val($(this).val());
  });


// revision jquery for searching
  $("#search_categories_revision").change(function(){
    if ($(this).val() == 0){
      $("#search_revision").val("");
      $("#search_revision").show();
      $("#allowance_sub_category_revision").hide();
    }else if($(this).val() == 1){
      $("#search_revision").val("");
      $("#search_revision").hide();
      $("#allowance_sub_category_revision").show();
      $("#allowance_sub_category_revision").change();
    }
  });

  $("#search_categories_revision").change();

  $("#allowance_sub_category_revision").change(function(){
    $("#search_revision").val($(this).val());
  });


   $("#transactionTab a").click(function (e) {
      e.preventDefault();
      $(this).tab("show");
    })