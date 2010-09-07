(function(){
  _.extend(pixelpong.app, { 
    VERSION : '0.2.1', // update on commit
    live : [],
    held : [],
    initialize : function(){
      if(window.pp_initialized) return false;
      var self = this;
      function render(ctor, name){
        try {
          var view = new ctor();
          if(view.query().string.length > 0)
            view.el.triggerHandler('_render') ?
              this.live.push(name) :
              this.held.push(name);
          
        } catch(e) { console.log(e); console.trace(); }
      }
      _.each(pixelpong.views, _.bind(render, this));
      return window.pp_initialized = true;
    }
  });
})();

$(document).ready(function(){
  pixelpong.app.initialize();
});