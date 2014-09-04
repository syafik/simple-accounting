    $('#myTab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
    })

    $('#will_paginate_id').bind('click', function(event){
      window.scrollTo(0,0);
      // Some code to show loader on screen
      $('#loading').html('<div class="ui active dimmer"><div class="ui large text loader">Loading</div></div>');
    });

    $("#reject_btn").click(function(){
      $("#decision").val("rejected");
    });

    $("#approve_btn").click(function(){
      $("#decision").val("approved");
    });

    $("#revision_btn").click(function(){
      $("#decision").val("revision");
    });

// pending jquery for searching
  $("#search_categories_pending").change(function(){
    if ($(this).val() == 1){
        
      $("#search_pending").val("");
      $("#search_pending").show();
      $("#allowance_sub_category_pending").hide();
    }else if($(this).val() == 2){
        
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


// approved jquery for searching
  $("#search_categories_approved").change(function(){
    if ($(this).val() == 1){
        
      $("#search_approved").val("");
      $("#search_approved").show();
      $("#allowance_sub_category_approved").hide();
    }else if($(this).val() == 2){
        
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
    if ($(this).val() == 1){
        
      $("#search_rejected").val("");
      $("#search_rejected").show();
      $("#allowance_sub_category_rejected").hide();
    }else if($(this).val() == 2){
        
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


// revision jquery for searching
  $("#search_categories_revision").change(function(){
    if ($(this).val() == 1){
        
      $("#search_revision").val("");
      $("#search_revision").show();
      $("#allowance_sub_category_revision").hide();
    }else if($(this).val() == 2){
        
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


    $(function() {
        $( "#from" ).datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 3,
            onClose: function( selectedDate ) {
                $( "#to" ).datepicker( "option", "minDate", selectedDate );
            }
        });
        $( "#to" ).datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 3,
            onClose: function( selectedDate ) {
                $( "#from" ).datepicker( "option", "maxDate", selectedDate );
            }
        });
    });