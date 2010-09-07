(function(){
  if(!Date.prototype.hasOwnProperty("toJSON"))
    Date.prototype.toJSON = function (key) {
        function f(n) {
            // Format integers to have at least two digits.
            return n < 10 ? '0' + n : n;
        }

        return this.getUTCFullYear()   + '-' +
             f(this.getUTCMonth() + 1) + '-' +
             f(this.getUTCDate())      + 'T' +
             f(this.getUTCHours())     + ':' +
             f(this.getUTCMinutes())   + ':' +
             f(this.getUTCSeconds())   + 'Z';
    };
})();