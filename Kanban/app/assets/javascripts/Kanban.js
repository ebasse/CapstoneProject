//import {Sortable, Plugins} from '@shopify/draggable';

function newTaskFunction() {
    
   /* var button = document.createElement("DIV");
    var buttonText = document.createTextNode("Created Task");
    button.setAttribute('class', 'taskBox');
    button.appendChild(buttonText);
    document.body.appendChild(button);
  */
  
  var mousePosition;
var offset = [0,0];
var div;
var isDown = false;

div = document.createElement("div");
div.style.position = "absolute";
div.style.left = "15px";
div.style.top = "582px";
div.style.width = "100px";
div.style.height = "100px";
div.style.background = "yellow";
div.style.color = "blue";

document.body.appendChild(div);

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