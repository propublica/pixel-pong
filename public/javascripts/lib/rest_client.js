pixelpong.models.RESTClient = pixelpong.Model.extend({
  init : function(attrs){
    this._super(attrs);
    
    if(this._attrs.url) this.url = this._attrs.url;
    if(!this.url){
      this.url = window.location.pathname;
      if(!(/^\/$/.test(this.url))){
        this.url.replace(/\.html$/, ".json");
        if(!(/\.json$/).test(this.url)) this.url += ".json";  
      } else {
        this.url += "index.json"; 
      }
    }
    // Inspired by [express.js](http://github.com/visionmedia/express/blob/master/lib/express/http.js)
    this._create("get");
    this._create("put");
    this._create("del");
    this._create("post");
  },
  
  _create : function(method){
    this[method] = function(payload, callback, err) {
      if(method === "del") method = "delete";
      if(method === "put" || method === "delete") {
        _.extend(payload, {_method: method.toUpperCase()});
        method = "post";
      }
      this._request.apply(this, ([method.toUpperCase()]).concat(_.toArray(arguments)));
    };
  },
  
  _request : function(method, payload, callback, err){
    err = err || function(req, stat, error){ console.log(req, stat, error); alert(error)};
    $.ajax({
      url : this.url,
      dataType : 'json',
      type : method,
      data : payload,
      success : callback,
      error: err
    });
  }
});

