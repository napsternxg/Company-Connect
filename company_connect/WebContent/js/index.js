var parameters = new Array("Name", "Location","Company","Experience","Industry","Skills","College","Degree","Trade");
var parametersAdded = new Array();
function onBlurField(field) {
			field.style.backgroundColor="#FFFFFF";
			field.style.color="#9D9FA2";
	}
	function onFocusField(field) {
			field.style.backgroundColor="#F5DEB3";
			field.style.color="#000000";
	}
function onSelectedOption(field){
	var i = field.selectedIndex;
	var value = field.options[i].value.toLowerCase();
	field.parentNode.getElementsByTagName('input')[0].setAttribute('name',value);
	/*if(parametersAdded.indexOf(String(value)) < 0) {
		parametersAdded.push(value);
		field.options.length=1;
		field.options[0].value = value;
		field.options[0].innerHTML = value;
	}
	else {
		field.remove(i);
	}
	//var attribute = document.createAttribute("disabled");
    //attribute.nodeValue = "disabled";
    //field.setAttributeNode(attribute);*/
}
function addNewSearch(){
	var ul= document.getElementById("search-options-list");
	var len = ul.getElementsByTagName('li').length;
	var index = ul.getElementsByTagName('li')[len-1].getAttribute('index');
	var liCount= len + 1;
	var oldElement = document.getElementById("search-select-" + index);
	if(oldElement.options.length > 0) {
		var i = oldElement.selectedIndex;
		var value = oldElement.options[i].value;
		if(parametersAdded.indexOf(String(value)) < 0) {
			parametersAdded.push(value);
			oldElement.options.length=1;
			oldElement.options[0].value = value;
			oldElement.options[0].innerHTML = value;
		}
	}
	var st="";
	if(liCount <= 9) {
		//remove already added fields
		var name="";
		var count = 0;
		for(var i=0; i<parameters.length; i++) {
			if(parametersAdded.indexOf(parameters[i])<0) {
				if(count == 0) {
					name= parameters[i].toLowerCase();
					count++;
				}
				st += "<option value='" + parameters[i] + "'>" + parameters[i] + "</option>";
			}
		}
		var newIndex = parseInt(document.getElementById('search-options-list').getElementsByTagName('li')[len-1].getAttribute('index')) + 1;
		var html= "<li class='search-option' id='search-option-" + newIndex + "' index='" + newIndex + "'><select  id='search-select-" + newIndex + "' onChange = onSelectedOption(this)>" + st + "</select><input type='text' class='input' id='input"+newIndex+"' value='' name='" + name + "' onFocus=onFocusField(this) onBlur=onBlurField(this)></input><button class= 'cross' onClick='return removeSearch(this)''>Remove</button></li>";
		$("#search-options-list").append(String(html));
		var newHeight = document.getElementById("search-box").offsetHeight + 30;
		document.getElementById("search-box").style.height = newHeight;
		var st = "height : " + newHeight + "px";
		document.getElementById("search-box").setAttribute('style', st);
	}
	return false;
}
function removeSearch(field){
	var ul= document.getElementById("search-options-list");
	var len = ul.getElementsByTagName('li').length;
	if(len>1) {
		elem = document.getElementById(field.parentNode.id);
		var value = elem.getElementsByTagName('option')[0].innerHTML;
		elem.parentNode.removeChild(elem);
		//change height of box
		var newHeight = document.getElementById("search-box").offsetHeight - 30;
		document.getElementById("search-box").style.height = newHeight;
		var st = "height : " + newHeight + "px";
		document.getElementById("search-box").setAttribute('style', st);
		//remove from parameters from Added
		var i= parametersAdded.indexOf(value);
		parametersAdded.splice(i, 1);
	}
	if(len==2){
		var firstElement = document.getElementById("search-options-list").getElementsByTagName('li')[0];
		firstElement.getElementsByTagName('select')[0].options.length=9;
		var value = firstElement.getElementsByTagName('select')[0].getElementsByTagName('option')[0].innerHTML;
		for(var i =1,j=0; i<9; i++,j++) {
			if(value == parameters[j]) { j++;}
			firstElement.getElementsByTagName('select')[0].options[i].value = parameters[j] ;
			firstElement.getElementsByTagName('select')[0].options[i].innerHTML = parameters[j];
		}
	}
	return false;
}

function ajaxRequest(){
	$(".results-main-container")[0].innerHTML = "";
	var data="";
	$(".input").each(function(i){
		if(this.value!=""){
		data+=this.name+"="+this.value+"&";
		}
		});
	if(data=="") return false;
	$.ajax({
        data: data,
        type: "POST",
        url: 'dbconnect1.jsp',
        success: function(data) {
			$(".results-main-container")[0].innerHTML = data;
 		   //alert("Data Loaded: " + data);
		 }
	});
	/*$.post("dbconnect1.jsp", '{'+data+'}', function(data) {
		   alert("Data Loaded: " + data);
		 });
		 */	
	return false;
}