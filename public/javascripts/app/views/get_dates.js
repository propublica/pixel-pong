pixelpong.views.getDates = pixelpong.View.extend({
  id: "get_dates",
  tag: 'a',
  bindings : {click : "refresh"},
  refresh: function(){
    var from = Date.parseString($("#from").val());
    var to = Date.parseString($("#to").val());
    $("#pixel-ping-view").trigger("refresh", [ from, to ]);
  }  
});