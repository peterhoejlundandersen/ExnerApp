(function() {
  var ready, set_positions;

  ready = void 0;

  set_positions = void 0;

  set_positions = function() {
    return $(".sortable-item").each(function(i) {
      $(this).attr("data-pos", i + 1);
    });
  };

  ready = function() {
    set_positions();
    $(".sortable").sortable();
    $(".sortable").sortable().bind("sortupdate", function(e, ui) {
      var updated_order;
      updated_order = [];
      set_positions();
      $(".sortable-item").each(function(i) {
        updated_order.push({
          id: $(this).data("id"),
          position: i + 1,
          type: $(this).data("type")
        });
      });
      $.ajax({
        type: "PUT",
        url: "/works/sort",
        data: {
          order: updated_order
        }
      });
    });
  };

  $(document).ready(ready);

}).call(this);
