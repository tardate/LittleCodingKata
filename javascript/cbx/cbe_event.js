/* cbe_event.js
 * CBE v4b10 : Cross-Browser DHTML API for IE, Gecko, Opera, Netscape, Konqueror and similar browsers. Download at cross-browser.com
 * Copyright (c) 2002 Michael Foster (mike@cross-browser.com)
 * This library is distributed under the terms of the GNU Lesser General Public License (gnu.org).
*/
function cbeELReg(eventType, eventListener, eventCapture) { // event listener registration object constructor
  this.type = eventType;
  this.listener = eventListener;
  this.capture = eventCapture;
}
function CrossBrowserEvent(e) { // Object constructor
  // eventPhase masks
  this.AT_TARGET = 1;
  this.BUBBLING_PHASE = 2;
  this.CAPTURING_PHASE = 3;
  // button masks
  this.LEFT = 0;
  this.MIDDLE = 1;
  this.RIGHT = 2;
  // properties
  if (is.ie) {
    // from DOM2 Interface Event
    this.type = window.event.type;
    this.target = window.event.srcElement;
    this.currentTarget = window.event.toElement; //?
    this.eventPhase = 0; //
    this.bubbles = 0; //
    this.cancelable = 0; //
    this.timeStamp = 0; //
    // from DOM2 Interface MouseEvent : UIEvent
    this.screenX = window.event.screenX;
    this.screenY = window.event.screenY;
    this.clientX = window.event.clientX;
    this.clientY = window.event.clientY;
    this.ctrlKey = window.event.ctrlKey;
    this.shiftKey = window.event.shiftKey;
    this.altKey = window.event.altKey;
    this.metaKey = 0; //
    if (this.type.indexOf('mouse') != -1) {
      if (window.event.button == 1) this.button = this.LEFT;
      else if (window.event.button == 4) this.button = this.MIDDLE;
      else if (window.event.button == 2) this.button = this.RIGHT;
      else this.button = 3; // undefined
    }
    else if (this.type == 'click') this.button = this.LEFT;
    else this.button = 4; // non-mouse event
    this.relatedTarget = window.event.fromElement; //?
    // from IE4+ Object Model
    this.keyCode = window.event.keyCode;
    this.offsetX = 0; // see below
    this.offsetY = 0; // see below
    // from NN4.xx Object Model
    this.pageX = this.clientX + document.cbe.scrollLeft();
    this.pageY = this.clientY + document.cbe.scrollTop();
  }  
  else if (is.gecko) {
    // from DOM2 Interface Event
    this.type = e.type;
    this.target = e.target;
    this.currentTarget = e.currentTarget;
    this.eventPhase = e.eventPhase;
    this.bubbles = e.bubbles;
    this.cancelable = e.cancelable;
    this.timeStamp = e.timeStamp;
    // from DOM2 Interface MouseEvent : UIEvent
    this.screenX = e.screenX;
    this.screenY = e.screenY;
    this.clientX = e.clientX;
    this.clientY = e.clientY;
    this.ctrlKey = e.ctrlKey;
    this.shiftKey = e.shiftKey;
    this.altKey = e.altKey;
    this.metaKey = e.metaKey;
    if (this.type.indexOf('mouse') != -1) {
      this.button = e.button;
      if (this.button < 0 || this.button > 2) this.button = 3; // undefined
    }
    else if (this.type == 'click') this.button = this.LEFT;
    else this.button = 4; // non-mouse event
    this.relatedTarget = e.relatedTarget;
    // from IE4+ Object Model
    this.keyCode = e.which;
    this.offsetX = e.layerX;
    this.offsetY = e.layerY;
    // from NN4.xx Object Model
    this.pageX = this.clientX + document.cbe.scrollLeft();
    this.pageY = this.clientY + document.cbe.scrollTop();
  }
  else if (is.nav) {
    // from DOM2 Interface Event
    this.type = e.type;
    this.target = e.target;
    this.currentTarget = null; //
    this.eventPhase = 0; //
    this.bubbles = 0; //
    this.cancelable = 0; //
    this.timeStamp = 0; //
    // from DOM2 Interface MouseEvent : UIEvent
    this.screenX = e.screenX;
    this.screenY = e.screenY;
    this.clientX = e.pageX - document.cbe.scrollLeft();
    this.clientY = e.pageY - document.cbe.scrollTop();
    this.ctrlKey = (e.modifiers & Event.CONTROL_MASK) != 0;
    this.shiftKey = (e.modifiers & Event.SHIFT_MASK) != 0; 
    this.altKey = (e.modifiers & Event.ALT_MASK) != 0;     
    this.metaKey = 0; //
    if (this.type.indexOf('mouse') != -1) {
      this.button = e.which - 1;
      if (this.button < 0 || this.button > 2) this.button = 3; // undefined
    }
    else if (this.type == 'click') this.button = this.LEFT;
    else this.button = 4; // non-mouse event
    this.relatedTarget = null; //
    // from IE4+ Object Model
    this.keyCode = e.which;
    this.offsetX = e.layerX;
    this.offsetY = e.layerY;
    // from NN4.xx Object Model
    this.pageX = e.pageX;
    this.pageY = e.pageY;
  }  
  else if (is.opera) {
    // from DOM2 Interface Event
    this.type = e.type;
    this.target = e.target;
    this.currentTarget = null; //
    this.eventPhase = 0; //
    this.bubbles = 0; //
    this.cancelable = 0; //
    this.timeStamp = 0; //
    // from DOM2 Interface MouseEvent : UIEvent
    this.screenX = e.screenX;
    this.screenY = e.screenY;
    this.clientX = e.clientX - document.cbe.scrollLeft();
    this.clientY = e.clientY - document.cbe.scrollTop();
    this.ctrlKey = e.type=='mousemove' ? e.shiftKey : e.ctrlKey;
    this.shiftKey = e.type=='mousemove' ? e.ctrlKey : e.shiftKey;
    this.altKey = e.altKey;
    this.metaKey =  0; //
    if ((e.type == 'click' && e.which == 0) || ((e.type == 'mousedown' || e.type == 'mouseup') && e.which == 1))
      this.button = this.LEFT;
    this.relatedTarget =  null; // this was crashing Opera, commented out in v3b12
    // from IE4+ Object Model
    this.keyCode = e.which;
    this.offsetX = 0; // see below
    this.offsetY = 0; // see below
    // from NN4.xx Object Model
    this.pageX = e.clientX;
    this.pageY = e.clientY;
  }
  // for the DOM2 event model
  this.bubbles = true;
  this.cancelable = true;
  this.stopPropagationFlag = false;
  this.preventDefaultFlag = false;
  // Find the event target
  if (is.nav4) {
    this.cbeTarget = cbeGetNodeFromPoint(this.pageX, this.pageY);
    // NN4 note: mouseout works only if mouseover and mouseout are both added to the same object
    if (this.type == 'mouseover') cbeMOT = this.cbeTarget; 
    else if (this.type == 'mouseout') this.cbeTarget = cbeMOT || document.cbe;
  }  
  else {
    var target = this.target;
    while (!target.cbe) target = cbeGetParentElement(target);
    this.cbeTarget = target.cbe;
  }
  this.cbeCurrentTarget = this.cbeTarget;
  //
  if (is.ie || is.opera) {
    this.offsetX = this.pageX - this.cbeTarget.pageX();
    this.offsetY = this.pageY - this.cbeTarget.pageY();
  }
}
CrossBrowserElement.prototype.addEventListener = function(eventType, eventListener, useCapture) {
//alert(this.id+'.addEventListener('+eventType+', L, '+useCapture+')');//////////////////////////debug
  if (!useCapture) useCapture = false;
  eventType = eventType.toLowerCase();
  if ((eventType.indexOf('mouse') != -1) || eventType == 'click' || (eventType.indexOf('key') != -1)) {
    var add=true;
    for (var i=0; i < this.listeners.length; ++i) { if (eventType == this.listeners[i].type) {add=false; break;} }  
    if (add) {
//      alert(this.id + ' add native ' + eventType);/////////////////////////debug
      cbeNativeAddEventListener(this.ele, eventType, cbePropagateEvent, false);
    }
    this.listeners[this.listeners.length] = new cbeELReg(eventType, eventListener, useCapture);
    return;
  }
  switch(eventType) {
    case 'slidestart': this.onslidestart = eventListener; return;
    case 'slide': this.onslide = eventListener; return;
    case 'slideend': this.onslideend = eventListener; return;
    case 'dragstart': this.ondragstart = eventListener; return;
    case 'drag':
      this.ondragCapture = useCapture;
      this.ondrag = eventListener;
      this.addEventListener('mousedown', cbeDragStartEvent, useCapture);
      return;
    case 'dragend': this.ondragend = eventListener; return;
    case 'dragresize': if (window.cbeUtilJsLoaded) cbeAddDragResizeListener(this); return;
    case 'scroll':
      if (is.nav || is.opera) {
        window.cbeOldScrollTop = cbePageYOffset();
        window.cbeOnScrollListener = eventListener;
        cbeScrollEvent();
        return;
      }
      break;
    case 'resize':
      if (is.nav4 || is.opera) {
        window.cbeOldWidth = cbeInnerWidth();
        window.cbeOldHeight = cbeInnerHeight();
        window.cbeOnResizeListener = eventListener;
        cbeResizeEvent();
        return;
      }
      break;
  } // end switch
  cbeNativeAddEventListener(this.ele, eventType, eventListener, useCapture);
}
function cbeNativeAddEventListener(ele, eventType, eventListener, useCapture) {
  if (!useCapture) useCapture = false;
  eventType = eventType.toLowerCase();
  var eh = "ele.on" + eventType + "=eventListener";
  if (is.dom2events) {
    ele.addEventListener(eventType, eventListener, useCapture);
  }  
  else if (ele.captureEvents) {
//    if (useCapture || (eventType.indexOf('mousemove')!=-1))  // ???
      ele.captureEvents(eval("Event." + eventType.toUpperCase()));
    eval(eh);
  }
  else { eval(eh); }  
}
function cbeNativeRemoveEventListener(ele, eventType, eventListener, useCapture) {
  if (!useCapture) useCapture = false;
  eventType = eventType.toLowerCase();
  var eh = "ele.on" + eventType + "=null";
  if (is.dom2events) {
    ele.removeEventListener(eventType, eventListener, useCapture);
  }  
  else if (ele.releaseEvents) {
//    if (useCapture || (eventType.indexOf('mousemove')!=-1))  // ???
      ele.releaseEvents(eval("Event." + eventType.toUpperCase()));
    eval(eh);
  }
  else { eval(eh); }  
}
CrossBrowserElement.prototype.removeEventListener = function(eventType, eventListener, useCapture) {
  eventType = eventType.toLowerCase();
  if (!useCapture) useCapture = false;
  if ((eventType.indexOf('mouse') != -1) || eventType == 'click' || (eventType.indexOf('key') != -1)) {
    var i;
    for (i = 0; i < this.listeners.length; ++i) {
      if (this.listeners[i].type == eventType && this.listeners[i].listener == eventListener && this.listeners[i].capture == useCapture) {
        if (this.listeners.splice) this.listeners.splice(i, 1);
        else this.listeners[i].type = "*";
        break;
      }
    }
    var remove=true;
    for (i = 0; i < this.listeners.length; ++i) { if (eventType == this.listeners[i].type) { remove = false; break; } }  
    if (remove) cbeNativeRemoveEventListener(this.ele, eventType, cbePropagateEvent, false);
    return;
  }
  switch(eventType) {
    case 'slidestart': this.onslidestart = null; return;
    case 'slide': this.onslide = null; return;
    case 'slideend': this.onslideend = null; return;
    case 'dragstart': this.ondragstart = null; return;
    case 'drag':
      this.removeEventListener('mousedown', cbeDragStartEvent, this.ondragCapture);
      this.ondrag = null;
      return;
    case 'dragend': this.ondragend = null; return;
    case 'dragresize': if (window.cbeUtilJsLoaded) cbeRemoveDragResizeListener(this); return;
    case 'scroll':
      if (is.nav || is.opera) {
        window.cbeOnScrollListener = null;
        return;
      }
      break;
    case 'resize':
      if (is.nav4 || is.opera) {
        window.cbeOnResizeListener = null;
        return;
      }
      break;
  } // end switch
  cbeNativeRemoveEventListener(this.ele, eventType, eventListener, useCapture);
}
CrossBrowserEvent.prototype.stopPropagation = function() { this.stopPropagationFlag = true; }
CrossBrowserEvent.prototype.preventDefault = function() { this.preventDefaultFlag = true; }
CrossBrowserElement.prototype.dispatchEvent= function(e) {
  var dispatch;
  e.cbeCurrentTarget = this;
  for (var i=0; i < this.listeners.length; ++i) {
    dispatch = false;
    if (e.type == this.listeners[i].type) {
      if (e.eventPhase == e.CAPTURING_PHASE) {
        if (this.listeners[i].capture) dispatch = true;
      }
      else if (!this.listeners[i].capture) dispatch = true;
    }
//    if (dispatch && e.type != 'mousemove') { alert('dispatching '+e.type+' to '+this.id+' during '+cbeEventPhase[e.eventPhase]) } /////////////////////////debug
    if (dispatch) { cbeEval(this.listeners[i].listener, e); }
  }
}
function cbePropagateEvent(evt) {
  var i=0, a=new Array();
  var e = new CrossBrowserEvent(evt);
  // Create an array of EventTargets, following the parent chain up (does not include cbeTarget)
  var node = e.cbeTarget.parentNode;
  while(node) {
    a[i++] = node;
    node = node.parentNode;
  }
  // The capturing phase
  e.eventPhase = e.CAPTURING_PHASE;
  for (i = a.length-1; i>=0; --i) {
    a[i].dispatchEvent(e);
    if (e.stopPropagationFlag) break;
  }
  // The at-target phase
  if (!e.stopPropagationFlag) {
    e.eventPhase = e.AT_TARGET;
    e.cbeTarget.dispatchEvent(e);
    // The bubbling phase
    if (!e.stopPropagationFlag && e.bubbles) {
      e.eventPhase = e.BUBBLING_PHASE;
      for (i = 0; i < a.length; ++i) {
        a[i].dispatchEvent(e);
        if (e.stopPropagationFlag) break;
      }
    }
  }
  //  Don't allow native bubbling
  if (is.ie) window.event.cancelBubble = true;
  else if (is.gecko) evt.stopPropagation();
  // Allow listener to cancel default action
  if (e.cancelable && e.preventDefaultFlag) {
    if (is.gecko || is.opera) evt.preventDefault();
    return false;
  }  
  else return true;
}
function cbeGetNodeFromPoint(x, y) {
  var hn /* highNode */, hz=0 /* highZ */, cn /* currentNode */, cz /* currentZ */;
  hn = document.cbe;
  while (hn.firstChild && hz >= 0) {
    hz = -1;
    cn = hn.firstChild;
    while (cn) {
      if (cn.contains(x, y)) {
        cz = cn.zIndex();
        if (cz >= hz) {
          hn = cn;
          hz = cz;
        }
      }
      cn = cn.nextSibling;
    }
  }
  return hn;
}
function cbeScrollEvent() {
  if (!window.cbeOnScrollListener) { return; }
  if (cbePageYOffset() != window.cbeOldScrollTop) {
    cbeEval(window.cbeOnScrollListener);
    window.cbeOldScrollTop = cbePageYOffset();
  }
  setTimeout("cbeScrollEvent()", 250);
}
function cbeResizeEvent() {
  if (!window.cbeOnResizeListener) { return; }
  if (cbeInnerWidth() != window.cbeOldWidth || cbeInnerHeight() != window.cbeOldHeight) {
    cbeEval(window.cbeOnResizeListener);
    window.cbeOldWidth = cbeInnerWidth();
    window.cbeOldHeight = cbeInnerHeight();
  }
  setTimeout("cbeResizeEvent()", 250);
}
function cbeDefaultResizeListener() {
  if (is.opera) location.replace(location.href);
  else history.go(0);
}
var cbeDragObj, cbeDragTarget, cbeDragPhase;
function cbeDragStartEvent(e) {
  if (is.opera) { var tn = e.target.tagName.toLowerCase(); if (tn == 'a') return; }
  else if (is.nav4) { if (e.target.href) return; }
  cbeDragObj = e.cbeCurrentTarget;
  cbeDragTarget = e.cbeTarget;
  if (cbeDragTarget.id == cbeDragObj.id) cbeDragPhase = e.AT_TARGET;
  else if (cbeDragObj.ondragCapture) cbeDragPhase = e.CAPTURING_PHASE;
  else cbeDragPhase = e.BUBBLING_PHASE;
  if (cbeDragObj) {
    if (cbeDragObj.ondragstart) { e.type = 'dragstart'; cbeEval(cbeDragObj.ondragstart, e); e.type = 'mousedown'; }
    cbeDragObj.x = e.pageX;
    cbeDragObj.y = e.pageY;
    document.cbe.addEventListener('mousemove', cbeDragEvent, cbeDragObj.ondragCapture);
    document.cbe.addEventListener('mouseup', cbeDragEndEvent, false);
  }
  e.stopPropagation();
  e.preventDefault();
}                                                    
function cbeDragEndEvent(e) {
  document.cbe.removeEventListener('mousemove', cbeDragEvent, cbeDragObj.ondragCapture);
  document.cbe.removeEventListener('mouseup', cbeDragEndEvent, false);
  if (cbeDragObj.ondragend) {
    e.type = 'dragend';
    e.cbeCurrentTarget = cbeDragObj;
    e.cbeTarget = cbeDragTarget;
    cbeEval(cbeDragObj.ondragend, e);
    e.type = 'mouseup';
  }
  //e.stopPropagation();
  e.preventDefault();
}
function cbeDragEvent(e) {
  if (cbeDragObj) {
    e.dx = e.pageX - cbeDragObj.x;
    e.dy = e.pageY - cbeDragObj.y;
    cbeDragObj.x = e.pageX;
    cbeDragObj.y = e.pageY;
    e.type = 'drag';
    e.cbeTarget = cbeDragTarget;
    e.cbeCurrentTarget = cbeDragObj;
    e.eventPhase = cbeDragPhase;
    if (cbeDragObj.ondrag) cbeEval(cbeDragObj.ondrag, e);
    else cbeDragObj.moveBy(e.dx,e.dy);
    e.type = 'mousemove';
  }
  //e.stopPropagation();
  e.preventDefault();
}
var cbeEventPhase = new Array('', 'AT_TARGET', 'BUBBLING_PHASE', 'CAPTURING_PHASE');
var cbeButton = new Array('LEFT', 'MIDDLE', 'RIGHT', 'undefined', 'non-mouse event');
CrossBrowserElement.prototype.ondragstart = null;
CrossBrowserElement.prototype.ondrag = null;
CrossBrowserElement.prototype.ondragend = null;
var cbeEventJsLoaded = true;
// End cbe_event.js