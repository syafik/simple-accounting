// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.min
//= require jquery-ui-1.10.3.min
//= require jquery_ujs
//= require bootstrap.min
//= require raphael-min
//= require morris.min
//= require jquery.sparkline
//= require jquery-jvectormap-1.2.2.min
//= require jquery-jvectormap-world-mill-en
//= require jquery.knob
//= require daterangepicker
//= require bootstrap-datepicker
//= require bootstrap3-wysihtml5.all.min
//= require icheck.min
//= require AdminLTE/app






function remove_fields(link) {
// console.log("test : ", $(link))
 //  $(link).previous("input[type=hidden]").value = "1";
 //  $(link).up(".fields").hide();
 $(link).parent().remove()
}


function add_fields2() {
  x =$("#nested-sub-category table").size()
  $(".wrapeer-sub-category").append("<div><table><tbody><tr><td>Nama</td><td><input type='text' size='30' placeholder='Nama Tunjangan' name='allowance_category[allowance_sub_categories_attributes]["+ x +"][name]' id='allowance_category_allowance_sub_categories_attributes_"+ x +"_name'></td></tr><tr><td>Masa Berlaku</td><td><input type='number' placeholder='Masa Berlaku' name='allowance_category[allowance_sub_categories_attributes]["+ x +"][max_day]' id='allowance_category_allowance_sub_categories_attributes_"+ x +"_max_day'></td></tr></tbody></table><a onclick='remove_fields(this); return false;' href='#''>remove</a></div>");
}
