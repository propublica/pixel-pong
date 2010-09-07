

pixelpong.View = Base.extend({
  // jquery object for our target
  el : null,
  // list of bindings to listen in on
  bindings : {},
  tag : 'div',
  cssClass : '',
  toggleClass : 'active',
  id : '',
  scope : '',
  
  init : function(){
    this.el = $(this.query().string);
    this.el.bind("_render", _.bind(this._render, this));
  },
  

  _render : function(){
    this.setBindings();
    this.render();
    return true;
  },
  
  render : function(){    
    return this;
  },
  
  query : function(){
    var self = this;
    var string = _.reduce([['', 'scope'], [' ', 'tag'], ['#', 'id'], ['.', 'cssClass']], function(memo, attr){
      return memo + (self[attr[1]].length > 0 ? attr[0] + self[attr[1]] : '');
    }, '');
    string.replace(/^\s+/, '');
    return { 
      string: string,
      scope: this.scope,
      tag: this.tag, 
      id: this.id, 
      cssClass: this.cssClass 
    };
  },

  setBindings : function(){
    var self = this;
    this.el.unbind();
    _.each(this.bindings, function(fn, key){
      self.el.bind(key, _.bind(self[fn], self));
    });
  }
});