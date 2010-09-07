
Date.parseString = function(val, format) {
	// If no format is specified, try a few common formats
	if (typeof(format)=="undefined" || format==null || format=="") {
		var generalFormats=new Array('y-M-d','MMM d, y','MMM d,y','y-MMM-d','d-MMM-y','MMM d','MMM-d','d-MMM');
		var monthFirst=new Array('M/d/y','M-d-y','M.d.y','M/d','M-d');
		var dateFirst =new Array('d/M/y','d-M-y','d.M.y','d/M','d-M');
		var checkList=new Array(generalFormats,Date.preferAmericanFormat?monthFirst:dateFirst,Date.preferAmericanFormat?dateFirst:monthFirst);
		for (var i=0; i<checkList.length; i++) {
			var l=checkList[i];
			for (var j=0; j<l.length; j++) {
				var d=Date.parseString(val,l[j]);
				if (d!=null) { 
					return d; 
				}
			}
		}
		return null;
	};

	this.isInteger = function(val) {
		for (var i=0; i < val.length; i++) {
			if ("1234567890".indexOf(val.charAt(i))==-1) { 
				return false; 
			}
		}
		return true;
	};
	this.getInt = function(str,i,minlength,maxlength) {
		for (var x=maxlength; x>=minlength; x--) {
			var token=str.substring(i,i+x);
			if (token.length < minlength) { 
				return null; 
			}
			if (this.isInteger(token)) { 
				return token; 
			}
		}
	return null;
	};
	val=val+"";
	format=format+"";
	var i_val=0;
	var i_format=0;
	var c="";
	var token="";
	var token2="";
	var x,y;
	var year=new Date().getFullYear();
	var month=1;
	var date=1;
	var hh=0;
	var mm=0;
	var ss=0;
	var ampm="";
	while (i_format < format.length) {
		// Get next token from format string
		c=format.charAt(i_format);
		token="";
		while ((format.charAt(i_format)==c) && (i_format < format.length)) {
			token += format.charAt(i_format++);
		}
		// Extract contents of value based on format token
		if (token=="yyyy" || token=="yy" || token=="y") {
			if (token=="yyyy") { 
				x=4;y=4; 
			}
			if (token=="yy") { 
				x=2;y=2; 
			}
			if (token=="y") { 
				x=2;y=4; 
			}
			year=this.getInt(val,i_val,x,y);
			if (year==null) { 
				return null; 
			}
			i_val += year.length;
			if (year.length==2) {
				if (year > 70) { 
					year=1900+(year-0); 
				}
				else { 
					year=2000+(year-0); 
				}
			}
		}
		else if (token=="MMM" || token=="NNN"){
			month=0;
			var names = (token=="MMM"?(Date.monthNames.concat(Date.monthAbbreviations)):Date.monthAbbreviations);
			for (var i=0; i<names.length; i++) {
				var month_name=names[i];
				if (val.substring(i_val,i_val+month_name.length).toLowerCase()==month_name.toLowerCase()) {
					month=(i%12)+1;
					i_val += month_name.length;
					break;
				}
			}
			if ((month < 1)||(month>12)){
				return null;
			}
		}
		else if (token=="EE"||token=="E"){
			var names = (token=="EE"?Date.dayNames:Date.dayAbbreviations);
			for (var i=0; i<names.length; i++) {
				var day_name=names[i];
				if (val.substring(i_val,i_val+day_name.length).toLowerCase()==day_name.toLowerCase()) {
					i_val += day_name.length;
					break;
				}
			}
		}
		else if (token=="MM"||token=="M") {
			month=this.getInt(val,i_val,token.length,2);
			if(month==null||(month<1)||(month>12)){
				return null;
			}
			i_val+=month.length;
		}
		else if (token=="dd"||token=="d") {
			date=this.getInt(val,i_val,token.length,2);
			if(date==null||(date<1)||(date>31)){
				return null;
			}
			i_val+=date.length;
		}
		else if (token=="hh"||token=="h") {
			hh=this.getInt(val,i_val,token.length,2);
			if(hh==null||(hh<1)||(hh>12)){
				return null;
			}
			i_val+=hh.length;
		}
		else if (token=="HH"||token=="H") {
			hh=this.getInt(val,i_val,token.length,2);
			if(hh==null||(hh<0)||(hh>23)){
				return null;
			}
			i_val+=hh.length;
		}
		else if (token=="KK"||token=="K") {
			hh=this.getInt(val,i_val,token.length,2);
			if(hh==null||(hh<0)||(hh>11)){
				return null;
			}
			i_val+=hh.length;
			hh++;
		}
		else if (token=="kk"||token=="k") {
			hh=this.getInt(val,i_val,token.length,2);
			if(hh==null||(hh<1)||(hh>24)){
				return null;
			}
			i_val+=hh.length;
			hh--;
		}
		else if (token=="mm"||token=="m") {
			mm=this.getInt(val,i_val,token.length,2);
			if(mm==null||(mm<0)||(mm>59)){
				return null;
			}
			i_val+=mm.length;
		}
		else if (token=="ss"||token=="s") {
			ss=this.getInt(val,i_val,token.length,2);
			if(ss==null||(ss<0)||(ss>59)){
				return null;
			}
			i_val+=ss.length;
		}
		else if (token=="a") {
			if (val.substring(i_val,i_val+2).toLowerCase()=="am") {
				ampm="AM";
			}
			else if (val.substring(i_val,i_val+2).toLowerCase()=="pm") {
				ampm="PM";
			}
			else {
				return null;
			}
			i_val+=2;
		}
		else {
			if (val.substring(i_val,i_val+token.length)!=token) {
				return null;
			}
			else {
				i_val+=token.length;
			}
		}
	}
	// If there are any trailing characters left in the value, it doesn't match
	if (i_val != val.length) { 
		return null; 
	}
	// Is date valid for month?
	if (month==2) {
		// Check for leap year
		if ( ( (year%4==0)&&(year%100 != 0) ) || (year%400==0) ) { // leap year
			if (date > 29){ 
				return null; 
			}
		}
		else { 
			if (date > 28) { 
				return null; 
			} 
		}
	}
	if ((month==4)||(month==6)||(month==9)||(month==11)) {
		if (date > 30) { 
			return null; 
		}
	}
	// Correct hours value
	if (hh<12 && ampm=="PM") {
		hh=hh-0+12; 
	}
	else if (hh>11 && ampm=="AM") { 
		hh-=12; 
	}
	return new Date(year,month-1,date,hh,mm,ss);
};
