//import {Sortable, Plugins} from '@shopify/draggable';


/*
// Following taken from https://stackoverflow.com/questions/12572644/differentiate-click-vs-mousedown-mouseup 
// Timeout, started on mousedown, triggers the beginning of a hold
var holdStarter = null;
// Milliseconds to wait before recognizing a hold
var holdDelay = 500;
// Indicates the user is currently holding the mouse down
var holdActive = false;
// MouseDown
function onMouseDown(event){
    // Do not take any immediate action - just set the holdStarter
    //  to wait for the predetermined delay, and then begin a hold
    holdStarter = setTimeout(function() {
        holdStarter = null;
        holdActive = true;
        // begin hold-only operation here, if desired
        
    }, holdDelay);
}
// MouseUp
function onMouseUp(event){
    // If the mouse is released immediately (i.e., a click), before the
    //  holdStarter runs, then cancel the holdStarter and do the click
    if (holdStarter) {
        clearTimeout(holdStarter);
        // run click-only operation here
    }
    // Otherwise, if the mouse was being held, end the hold
    else if (holdActive) {
        holdActive = false;
        // end hold-only operation here, if desired
    }
}


function onMouseMove(event){
    
}
//End of Stack Exchange functions
*/

function newTaskFunction(x,y,id_num) {
    
   /* var button = document.createElement("DIV");
    var buttonText = document.createTextNode("Created Task");
    button.setAttribute('class', 'taskBox');
    button.appendChild(buttonText);
    document.body.appendChild(button);
  */
  if (x==-1){
      x = 15;
      y = 582;
  }
  var mousePosition;
var offset = [0,0];
var div;
var isDown = false;
var wasDragged = false;

div = document.createElement("div");
div.style.position = "absolute";
div.style.left = x + "px";
div.style.top = y + "px";
div.style.width = "100px";
div.style.height = "100px";
div.style.background = "yellow";
div.style.color = "blue";
div.setAttribute("id",id_num);

//window.alert(id_num.toString());

document.body.appendChild(div);

div.addEventListener('click', function(e) {
    if (wasDragged === false){
        window.alert(e.target.getAttribute("id").toString());
    }
    wasDragged = false;
}, true);

div.addEventListener('mousedown', function(e) {
    isDown = true;
    
    offset = [
        div.offsetLeft - e.clientX,
        div.offsetTop - e.clientY
    ];
}, true);

document.addEventListener('mouseup', function() {
    isDown = false;
}, true);

document.addEventListener('mousemove', function(event) {
    event.preventDefault();
     
    if (isDown) {
        wasDragged = true;
        mousePosition = {
            

            x : event.clientX,
            y : event.clientY

        };
        div.style.left = (mousePosition.x + offset[0]) + 'px';
        div.style.top  = (mousePosition.y + offset[1]) + 'px';
    }
}, true);
}
//dragElement(document.getElementById("taskBox"));