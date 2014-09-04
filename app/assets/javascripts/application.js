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
//= require jquery
//= require jquery_ujs
//= require jquery.formatCurrency-1.4.0.min
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr



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
