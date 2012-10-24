// overrides spree core's version to include our variant configurations
$(document).ready(function(){

  $("#add_line_item_to_order").live("click", function(){
    if($('#add_variant_id').val() == ''){ return false; }
    update_target = $(this).attr("data-update");
    $.ajax({ dataType: 'script', url: this.href, type: "POST",
        data: {"line_item[variant_id]": $('#add_variant_id').val(),
               "line_item[quantity]": $('#add_quantity').val(),
               "variant_configurations": $('#variant_configurations').serialize()
              }
    });
    return false;
  });

  $("#add_product_name").product_autocomplete();

  // Delete customized_product_option
  $('body').on('click', '.delete-customization-image', function() {
    var el = $(this);
    if (confirm(el.data("confirm"))) {
      $.ajax({
        type: 'POST',
        url: $(this).attr("href"),
        data: {
          _method: 'delete',
          authenticity_token: AUTH_TOKEN
        },
        dataType: 'script',
        success: function(response) {
          el.parents("dd").fadeOut('hide');
        },
        error: function(response, textStatus, errorThrown) {
          show_flash_error(response.responseText);
        }
      });
    }
    return false;
  });

});

