

pixelpong.Model = Base.extend({

  
  
  init : function(attrs){
    this._attrs = this._attrs || {};
    _.extend(this._attrs, attrs);
    this.id = _.uniqueId(this.read("name") || "");
  },
  
  read : function(key){
    return this._attrs[key] || null;
  },
  
  write : function(key, attr){
    var oldAttr = this._attrs[key];
    this._attrs[key] = attr;
    this._onchange(oldAttr);
    return oldAttr;
  },
  
  remove : function(key){
    var oldAttr = this._attrs[key];
    delete this._attrs[key];
    this._onchange(oldAttr);
    return oldAttr;
  },

  copy : function(){
    return new (this.init)(this._attrs);
  },
  
  _onchange : function(oldAttr){
    if(this.MODEL_CHANGED) this.fire(this.MODEL_CHANGED, this.id, oldAttr);
  },
  
  bind : function(e, cb){
    var callbacks = (this._callbacks = this._callbacks || {});
    var list = (callbacks[e] = callbacks[e] || []);
    list.push(cb);
  },
  
  unbind : function(e, cb){
    if(!(this._callbacks && this._callbacks[e])) return;
    var list = this._callbacks[e];
    for(var i = 0; i < list.length; i++){
      if(list[i] === cb) { 
        list.splice(i, 1);
        break;
      }
    }
  },
  
  unbindAll : function(){
    delete this._callbacks();
  },
  
  fire : function(e){
    if(!this._callbacks) return;
    var list = this._callbacks[e];
    if(!list) return;
    for(var i = 0; i < list.length; i++) list[i].apply(this, arguments);
  }
  
});