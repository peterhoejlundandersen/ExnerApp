(function() {
  var ready, set_positions;

  ready = void 0;

  set_positions = void 0;

  set_positions = function() {
    return $(".sortable-image-item").each(function(i) {
      $(this).attr("data-pos", i + 1);
    });
  };

  ready = function() {
    set_positions();
    $(".sortable-images").sortable();
    $(".sortable-images").sortable().bind("sortupdate", function(e, ui) {
      var updated_order;
      updated_order = [];
      set_positions();
      $(".sortable-image-item").each(function(i) {
        updated_order.push({
          id: $(this).data("id"),
          type: $(this).data("type"),
          position: i + 1
        });
      });
      $.ajax({
        type: "PUT",
        url: "/works/:id/sort_images",
        data: {
          order: updated_order
        }
      });
    });
  };

  $(document).ready(ready);

}).call(this);
