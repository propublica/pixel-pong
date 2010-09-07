pixelpong.views.pixelPing = pixelpong.View.extend({
  id : "pixel-ping-view",
  bindings: { "refresh" : "get" },
  init : function(){
    this.client = new pixelpong.models.pingClient({url: "/stats"});
    this._super();
  },
  render : function(){
    this.get();
  },
  
  get : function(caller, startDate, endDate){
    var self = this,
      params = {}
    ;
    if(startDate !== undefined && endDate !== undefined) params = {start_date: startDate.toJSON(), end_date: endDate.toJSON()};
    this.client.get(params, function(data){
      total = _.reduce(data, function(memo, num){ return memo + num.stat.hits }, 0);
      self.el.html(window.JST.table({stats: data, total: total}));
    });
  }
});