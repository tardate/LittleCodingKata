/* cbe_core.js
 * CBE v4b10 : Cross-Browser DHTML API for IE, Gecko, Opera, Netscape, Konqueror and similar browsers. Download at cross-browser.com
 * Copyright (c) 2002 Michael Foster (mike@cross-browser.com)
 * This library is distributed under the terms of the GNU Lesser General Public License (gnu.org).
*/
var
  cbeVersion = "v4b10",
  cbeDocumentId = 'idDocument',
  cbeWindowId = 'idWindow',
  cbeAll = new Array();
window.onload = function() {
  cbeInitialize();
  if (window.windowOnload) window.windowOnload();
}
window.onunload = function() {
  if (window.windowOnunload) window.windowOnunload();
  if (window.cbeDebugObj) window.cbeDebugObj = null;
  for (var i = 0; i < cbeAll.length; i++) {
    cbeAll[i].ele.cbe = null;
    cbeAll[i].ele = null;
    cbeAll[i] = null;
  }
}
function CrossBrowserNode() { // CrossBrowserNode Object Constructor
  this.parentNode = null;
  this.childNodes = 0;
  this.firstChild = null;
  this.lastChild = null;
  this.previousSibling = null;
  this.nextSibling = null;
}
CrossBrowserNode.prototype.appendNode = function(cbeChild) {
  if (cbeChild) {
    if (!this.firstChild) this.firstChild = cbeChild;
    else {
      cbeChild.previousSibling = this.lastChild;
      this.lastChild.nextSibling = cbeChild;
    }
    cbeChild.parentNode = this;
    this.lastChild = cbeChild;
    ++this.childNodes;
  }
  return cbeChild;
}
CrossBrowserElement.prototype = new CrossBrowserNode; // CrossBrowserElement is derived from CrossBrowserNode
function CrossBrowserElement(ele) { // CrossBrowserElement Object Constructor
  // bind methods
  this.left = domLeft;
  this.top = domTop;
  this.width = domWidth;
  this.height = domHeight;
  this.offsetLeft = domOffsetLeft;
  this.offsetTop = domOffsetTop;
  this.pageX = domPageX;
  this.pageY = domPageY;
  this.zIndex = domZIndex;
  this.innerHtml = domInnerHtml;
  this.visibility = domVisibility;
  this.color = domColor;
  this.background = domBackground;
  this.clip = domClip;
  if (is.ie) {                      // IE
    this.left = ieLeft;
    this.top = ieTop;
    if (is.ie6up && document.compatMode=="CSS1Compat") {  // "BackCompat" is the other valid value
      this.width = domWidth;
      this.height = domHeight;
    }
    else {
      this.width = ieWidth;
      this.height = ieHeight;
    }
  }
  else if (is.opera) {              // Opera
    this.left = ieLeft;
    this.top = ieTop;
    this.width = ieWidth;
    this.height = ieHeight;
    this.clip = cbeReturnVoid;
    this.innerHtml = cbeReturnVoid;
  }
  else if (is.nav4) {               // NN4
    this.left = nnLeft;
    this.top = nnTop;
    this.pageX = nnPageX;
    this.pageY = nnPageY;
    this.width = nnWidth;
    this.height = nnHeight;
    this.offsetLeft = nnOffsetLeft;
    this.offsetTop = nnOffsetTop;
    this.visibility = nnVisibility;
    this.zIndex = nnZIndex;
    this.background = nnBackground;
    this.color = cbeReturnZero;
    this.clip = nnClip;
    this.innerHtml = nnInnerHtml;
  }                                 // else assume Gecko or other DOM2 browser
  // setup
  this.index = cbeAll.length;
  cbeAll[this.index] = this;
  this.w = this.h = this.x = this.y = 0;
  if (window.cbeEventJsLoaded) this.listeners = new Array();
  if (ele) cbeBindElement(this, ele);
}
function cbeBindElement(cbe, ele) {
  if (!cbe || !ele) return;
  if (ele == window) cbe.id = ele.id = cbeWindowId;
  else if (ele == document) cbe.id = ele.id = cbeDocumentId;
  else cbe.id = ele.id;
  cbe.ele = ele;
  cbe.ele.cbe = cbe;
  cbe.parentElement = cbeGetParentElement(ele);
  if (cbe.index > 1) {
    if (is.nav4) { cbe.w = ele.clip.width; cbe.h = ele.clip.height; }
    else if (is.opera) { cbe.w = ele.style.pixelWidth; cbe.h = ele.style.pixelHeight; }
    else { cbe.w = ele.offsetWidth; cbe.h = ele.offsetHeight; }
  }
}
function cbeInitialize() {
  var i, ele, divArray, cbe;
  if (!document.getElementById) document.getElementById = cbeGetElementById;
  cbe = new CrossBrowserElement(window);
  cbe = new CrossBrowserElement(document);
  divArray = cbeGetElementsByTagName('DIV');
  for (i = 0; i < divArray.length; i++) {
    ele = divArray[i];
    if ( ele.id != "") { cbe = new CrossBrowserElement(ele); }
  }
  if (!is.nav4) {
    divArray = cbeGetElementsByTagName('SPAN');
    for (i = 0; i < divArray.length; i++) {
      ele = divArray[i];
      if ( ele.id != "") { cbe = new CrossBrowserElement(ele); }
    }
  }
  cbeCreateTree();
  if (window.cbeEventJsLoaded && (is.nav4 || is.opera)) { window.cbe.addEventListener("resize", cbeDefaultResizeListener); }
  with (window.cbe) {
    left = top = pageX = pageY = offsetLeft = offsetTop = zIndex = cbeReturnZero; 
    visibility = color = background = cbeReturnNull;
  }  
  with (document.cbe) {
    left = top = pageX = pageY = offsetLeft = offsetTop = zIndex = cbeReturnZero;
    visibility = color = background = cbeReturnNull;
  }
}
function cbeCreateTree() {
  var parent;
  for (var i = 1; i < cbeAll.length; ++i) {
    parent = cbeAll[i].parentElement;
    if (!parent.cbe) {
      while (parent && !parent.cbe) parent = cbeGetParentElement(parent);
      if (!parent) parent = document;
    }
    parent.cbe.appendNode(cbeAll[i]);
  }
}
function cbeGetElementById(eleId) {
  var ele = null;
  if (eleId == window.cbeWindowId) ele = window;
  else if (eleId == window.cbeDocumentId) ele = document;
  else if (is.dom1getbyid) ele = document.getElementById(eleId);
  else if (document.all) ele = document.all[eleId];
  else if (document.layers) ele = nnGetElementById(eleId);
  if (!ele && window.cbeUtilJsLoaded) {
    ele = cbeGetImageByName(eleId);
    if (!ele) ele = cbeGetFormByName(eleId);
  }
  return ele;
}
function nnGetElementById(eleId) {
  for (var i = 0; i < cbeAll.length; i++) {
    if ( cbeAll[i].id == eleId ) return cbeAll[i].ele;
  }
  return null;
}
function cbeGetElementsByTagName(tagName) {
  var eleArray;
  if (is.opera) eleArray = document.body.getElementsByTagName(tagName);
  else if (is.ie4) eleArray = document.all.tags(tagName);
  else if (is.ie5up || is.gecko || is.nav5up) eleArray = document.getElementsByTagName(tagName);
  else if (is.nav4) {
    eleArray = new Array();
    nnGetAllLayers(window, eleArray, 0);
  }
  return eleArray;
}
function nnGetAllLayers(parent, layerArray, nextIndex) {
  var i, layer;
  for (i = 0; i < parent.document.layers.length; i++) {
    layer = parent.document.layers[i];
    layerArray[nextIndex++] = layer;
    if (layer.document.layers.length) nextIndex = nnGetAllLayers(layer, layerArray, nextIndex);
  }
  return nextIndex;
}
function cbeGetParentElement(child) {
  var parent = document;
  if (child == window) parent = null;
  else if (child == document) parent = window;
  else if (is.nav4) {
    if (child.parentLayer) {
      if (child.parentLayer != window) parent = child.parentLayer;
    }
  }
  else {
    if (child.offsetParent) parent = child.offsetParent;
    else if (child.parentNode) parent = child.parentNode;
    else if (child.parentElement) parent = child.parentElement;
  }
  return parent;
}

////// when optimizing, don't remove anything above this comment //////

CrossBrowserNode.prototype.appendChild = function(eleChild) {
  var ele, rv = null;
  if (is.nav4) {
    var thisEle;
    if (this.index < 2) thisEle = window;
    else thisEle = this.ele;
    ele = new Layer(this.width(), thisEle);
    if (ele) {
      if (eleChild.id) ele.id = ele.name = eleChild.id;
      ele.cbe = eleChild.cbe;
      ele.cbe.ele = ele;
      cbeBindElement(ele.cbe, ele);
      this.appendNode(ele.cbe);
      rv = eleChild;
    }
  }
  else {
    if (this.index < 2) ele = document.body;
    else ele = this.ele;
    if (ele.appendChild) {
      ele.appendChild(eleChild);
      cbeBindElement(eleChild.cbe, eleChild);
      this.appendNode(eleChild.cbe);
      rv = eleChild;
    }
  }
  return rv;
}
CrossBrowserElement.prototype.createElement = function(sEleType) {
  var ele = null;
  if (document.createElement && sEleType.length) {
    ele = document.createElement(sEleType);
    if (ele) {
      ele.style.position = 'absolute';
      ele.cbe = new CrossBrowserElement();
      ele.cbe.ele = ele;
    }
  }
  else if (is.nav4) {
    ele = new Object();
    ele.cbe = new CrossBrowserElement();
  }
  return ele;  
}
CrossBrowserElement.prototype.contains = function(leftPoint, topPoint, top, right, bottom, left) {
  if (arguments.length == 2) top = right = bottom = left = 0;
  else if (arguments.length == 3) right = bottom = left = top;
  else if (arguments.length == 4) { left = right; bottom = top; }
  var x = this.pageX();
  var y = this.pageY();
  return (
    leftPoint >= x + left &&
    leftPoint <= x + this.width() - right &&
    topPoint >= y + top &&
    topPoint <= y + this.height() - bottom
  );
}
CrossBrowserElement.prototype.moveTo = function(x_cr, y_mar, outside, endListener) {
  if (isFinite(x_cr)) { this.left(x_cr); this.top(y_mar); }
  else {
    this.cardinalPosition(x_cr, y_mar, outside);
    this.left(this.x); this.top(this.y);
  }
  if (endListener) cbeEval(endListener, this);
}
CrossBrowserElement.prototype.moveBy = function(dX, dY, endListener) {
  if (dX) this.left(this.left() + dX);
  if (dY) this.top(this.top() + dY);
  if (endListener) cbeEval(endListener, this);
}
function domLeft(newLeft) {
  if (arguments.length) this.ele.style.left = newLeft + "px";
  else return parseInt(this.ele.style.left);
}
function ieLeft(newLeft) {
  if (arguments.length) this.ele.style.pixelLeft = newLeft;
  else return this.ele.style.pixelLeft;
}
function nnLeft(newLeft) {
  if (arguments.length) this.ele.left = newLeft;
  else return this.ele.left;
}
function domTop(newTop) {
  if (arguments.length) this.ele.style.top = newTop + "px";
  else return parseInt(this.ele.style.top);
}
function ieTop(newTop) {
  if (arguments.length) this.ele.style.pixelTop = newTop;
  else return this.ele.style.pixelTop;
}
function nnTop(newTop) {
  if (arguments.length) this.ele.top = newTop;
  else return this.ele.top;
}
function nnOffsetLeft() {
  var parent = this.parentElement;
  var ol = this.ele.pageX - parent.pageX;
  if (isNaN(ol)) ol = this.ele.pageX;
  return ol;
}
function nnOffsetTop() {
  var parent = this.parentElement;
  var ot = this.ele.pageY - parent.pageY;
  if (isNaN(ot)) ot = this.ele.pageY;
  return ot;
}
function domOffsetLeft() {
  var x = this.ele.offsetLeft;
  var parent = this.ele.offsetParent;
  while(parent && !parent.cbe) {
    x += parent.offsetLeft;
    parent = parent.offsetParent;
  }
  return x;
}
function domOffsetTop() {
  var y = this.ele.offsetTop;
  var parent = this.ele.offsetParent;
  while(parent && !parent.cbe) {
    y += parent.offsetTop;
    parent = parent.offsetParent;
  }
  return y;
}
function nnPageX() { return this.ele.pageX; }
function nnPageY() { return this.ele.pageY; }
function domPageX() {
  var x = this.offsetLeft();
  var parent = this.parentNode;
  if (parent) {
    while(parent.index > 1) {
      x += parent.offsetLeft();
      parent = parent.parentNode;
    }
  }
  return x;
}
function domPageY() {
  var y = this.offsetTop();
  var parent = this.parentNode;
  if (parent) {
    while(parent.index > 1) {
      y += parent.offsetTop();
      parent = parent.parentNode;
    }
  }
  return y;
}
CrossBrowserElement.prototype.sizeTo = function(newWidth, newHeight) {
  this.width(newWidth);
  this.height(newHeight);
}
CrossBrowserElement.prototype.sizeBy = function(dW, dH) {
  this.width(this.width() + dW);
  this.height(this.height() + dH);
}
CrossBrowserElement.prototype.resizeTo = function(newWidth, newHeight, endListener) {
  this.sizeTo(newWidth, newHeight);
  this.clip('auto');
  cbeEval(endListener, this);
}
CrossBrowserElement.prototype.resizeBy = function(dW, dH, endListener) {
  this.sizeBy(dW, dH);
  this.clip('auto');
  cbeEval(endListener, this);
}
function domWidth(newWidth) {
  if (arguments.length) {
    newWidth = Math.round(newWidth);
    if (is.ie6up || (is.gecko && !is.konq)) css1SetWidth(this.ele, newWidth);
    else this.ele.style.width = newWidth + "px";
    this.w = newWidth;
  }
  else if (this.index <= 1) this.w = cbeInnerWidth();
  return this.w
}
function ieWidth(newWidth) {
  if (arguments.length) {
    this.w = Math.round(newWidth);
    this.ele.style.pixelWidth = newWidth;
  }
  else if (this.index <= 1) this.w = cbeInnerWidth();
  return this.w
}
function nnWidth(newWidth) {
  if (arguments.length) this.w = Math.round(newWidth);
  else if (this.index <= 1) this.w = cbeInnerWidth();
  return this.w
}
function domHeight(newHeight) {
  if (arguments.length) {
    newHeight = Math.round(newHeight);
    if (is.ie6up || (is.gecko && !is.konq)) css1SetHeight(this.ele, newHeight);
    else this.ele.style.height = newHeight + "px";
    this.h = newHeight;
  }
  else if (this.index <= 1) this.h = cbeInnerHeight();
  return this.h
}
function ieHeight(newHeight) {
  if (arguments.length) {
    this.h = Math.round(newHeight);
    this.ele.style.pixelHeight = newHeight;
  }
  else if (this.index <= 1) this.h = cbeInnerHeight();
  return this.h
}
function nnHeight(newHeight) {
  if (arguments.length) this.h = Math.round(newHeight);
  else if (this.index <= 1) this.h = cbeInnerHeight();
  return this.h
}
function css1SetWidth(ele,w) {
  var cw,pb;
  if (is.gecko) cw = document.defaultView.getComputedStyle(ele,'').getPropertyValue("width");
  else cw = ele.currentStyle.width;
  cw = parseInt(cw);
  if (!isNaN(cw)) { // in IE6 cw could == 'auto'
    pb = ele.offsetWidth - cw; // padding and border widths
    w -= pb;
  }  
  ele.style.width = w + "px";
}
function css1SetHeight(ele,h) {
  var ch,pb;
  if (is.gecko) ch = document.defaultView.getComputedStyle(ele,'').getPropertyValue("height");
  else ch = ele.currentStyle.height;
  ch = parseInt(ch);
  if (!isNaN(ch)) { // in IE6 ch could == 'auto'
    pb = ele.offsetHeight - ch; // padding and border heights
    h -= pb;
  }  
  ele.style.height = h + "px";
}
CrossBrowserElement.prototype.scrollLeft = function() {
  var value = 0;
  if (this.ele.scrollLeft) value = this.ele.scrollLeft;
  else if (this.index <= 1) value = cbePageXOffset();
  return value;
}
CrossBrowserElement.prototype.scrollTop = function() {
  var value = 0;
  if (this.ele.scrollTop) value = this.ele.scrollTop;
  else if (this.index <= 1) value = cbePageYOffset();
  return value;
}
CrossBrowserElement.prototype.show = function() { this.visibility(1); }
CrossBrowserElement.prototype.hide = function() { this.visibility(0); }
function domVisibility(vis) {
  if (arguments.length) {
    if (vis) this.ele.style.visibility = is.opera ? 'visible' : 'inherit';
    else this.ele.style.visibility = 'hidden';
  }
  else return (this.ele.style.visibility == 'visible' || this.ele.style.visibility == 'inherit' || this.ele.style.visibility == '');
}
function nnVisibility(vis) {
  if (arguments.length) {
    if (vis) this.ele.visibility = 'inherit';
    else this.ele.visibility = 'hide';
  }
  else return (this.ele.visibility == 'show' || this.ele.visibility == 'inherit' || this.ele.visibility == '');
}
function domZIndex(newZ) {
  if (arguments.length) this.ele.style.zIndex = newZ;
  else return this.ele.style.zIndex
}
function nnZIndex(newZ) {
  if (arguments.length) this.ele.zIndex = newZ;
  else return this.ele.zIndex;
}
function domBackground(newBgColor, newBgImage) {
  if (arguments.length) {
    if (!newBgColor) newBgColor = 'transparent';
    if (!is.opera) this.ele.style.backgroundColor = newBgColor;
    else this.ele.style.background = newBgColor;
    if (arguments.length == 2) this.ele.style.backgroundImage = "url(" + newBgImage + ")";
  }
  else {
    if (!is.opera) return this.ele.style.backgroundColor;
    else return this.ele.style.background;
  }
}
function nnBackground(newBgColor, newBgImage) {
  if (arguments.length) {
    if (newBgColor == 'transparent') newBgColor = null;
    this.ele.bgColor = newBgColor;
    if (arguments.length == 2) this.ele.background.src = newBgImage || null;
  }
  else {
    var bg = this.ele.bgColor;
    if (window.cbeUtilJsLoaded) bg = cbeHexString(bg,6,'#');
    return bg;
  }
}
function domColor(newColor) {
  if (arguments.length) this.ele.style.color = newColor;
  else return this.ele.style.color;
}
function domClip(top, right, bottom, left) {
  if (arguments.length == 4) {
    var clipRect = "rect(" + top + "px " + right + "px " + bottom + "px " + left + "px" + ")";
    this.ele.style.clip = clipRect;
  }
  else this.clip(0, this.ele.offsetWidth, this.ele.offsetHeight, 0); // was...  this.clip(0, this.width(), this.height(), 0);
}
function nnClip(top, right, bottom, left) {
  if (arguments.length == 4) {
    this.ele.clip.top = top;
    this.ele.clip.right = right;
    this.ele.clip.bottom = bottom;
    this.ele.clip.left = left;
  }
  else this.clip(0, this.width(), this.height(), 0);
}
// all other clip methods moved to cbe_clip.js (v3b15)
function domInnerHtml(newHtml) {
  if (arguments.length) this.ele.innerHTML = newHtml;
  else return this.ele.innerHTML;
}
function nnInnerHtml(newHtml) {
  if (arguments.length) {
    if (newHtml == '') newHtml = ' ';
    this.ele.document.open();
    this.ele.document.write(newHtml);
    this.ele.document.close();
  }
  else return "";
}
CrossBrowserElement.prototype.cardinalPosition = function(cp, margin, outside) {
  if (typeof(cp) != 'string') { window.status = 'cardinalPosition() error: cp = ' + cp + ', id = ' + this.id; return; }
  var x = this.left();
  var y = this.top();
  var w = this.width();
  var h = this.height();
  var pw = this.parentNode.width();
  var ph = this.parentNode.height();
  var sx = this.parentNode.scrollLeft();
  var sy = this.parentNode.scrollTop();
  var right = sx + pw;
  var bottom = sy + ph;
  var cenLeft = sx + Math.floor((pw-w)/2);
  var cenTop = sy + Math.floor((ph-h)/2);
  if (!margin) margin = 0;
  else {
    if (outside) margin = -margin;
    sx += margin;
    sy += margin;
    right -= margin;
    bottom -= margin;
  }
  switch (cp.toLowerCase()) {
    case 'n': x = cenLeft; if (outside) y = sy - h; else y = sy; break;
    case 'ne': if (outside) { x = right; y = sy - h; } else { x = right - w; y = sy; } break;
    case 'e': y = cenTop; if (outside) x = right; else x = right - w; break;
    case 'se': if (outside) { x = right; y = bottom; } else { x = right - w; y = bottom - h } break;
    case 's': x = cenLeft; if (outside) y = sy - h; else y = bottom - h; break;
    case 'sw': if (outside) { x = sx - w; y = bottom; } else { x = sx; y = bottom - h; } break;
    case 'w': y = cenTop; if (outside) x = sx - w; else x = sx; break;
    case 'nw': if (outside) { x = sx - w; y = sy - h; } else { x = sx; y = sy; } break;
    case 'cen': case 'center': x = cenLeft; y = cenTop; break;
    case 'cenh': x = cenLeft; break;
    case 'cenv': y = cenTop; break;
  }
  this.x = x;
  this.y = y;
}
function cbeInnerWidth() {
  var w = 0;
  if (is.nav4up) {
    w = window.innerWidth;
    if (document.height > window.innerHeight) w -= 16;
  }
  else if (is.ie6up) w = (document.compatMode == 'CSS1Compat') ? document.documentElement.clientWidth : document.body.clientWidth;
  else if (is.ie4up) w = document.body.clientWidth;
  else if (is.opera) w = window.innerWidth;
  return w;
}
function cbeInnerHeight() {
  var h = 0;
  if (is.nav4up) {
    h = window.innerHeight;
    if (document.width > window.innerWidth) h -= 16;
  }
  else if (is.ie6up) h = (document.compatMode == 'CSS1Compat') ? document.documentElement.clientHeight : document.body.clientHeight;
  else if (is.ie4up) h = document.body.clientHeight;
  else if (is.opera) h = window.innerHeight;
  return h;
}
function cbePageXOffset() {
  var offset=0;
  if (is.nav4up || is.opera) offset = window.pageXOffset;
  else if (is.ie6up) offset = (document.compatMode == 'CSS1Compat') ? document.documentElement.scrollLeft : document.body.scrollLeft;
  else if (is.ie4up) offset = document.body.scrollLeft;
  return offset;
}
function cbePageYOffset() {
  var offset=0;
  if (is.nav4up || is.opera) offset = window.pageYOffset;
  else if (is.ie6up) offset = (document.compatMode == 'CSS1Compat') ? document.documentElement.scrollTop : document.body.scrollTop;
  else if (is.ie4up) offset = document.body.scrollTop;
  return offset;
}
function cbeReturnZero() { return 0; }
function cbeReturnNull() { return null; }
function cbeReturnVoid() { }
function cbeEval(exp, arg1, arg2, arg3, arg4, arg5, arg6) {
  if (exp) {
    if (typeof(exp)=="string") eval(exp);
    else exp(arg1, arg2, arg3, arg4, arg5, arg6);
  }
}
function ClientSnifferJr() { // Object Constructor
  this.ua = navigator.userAgent.toLowerCase();
  this.major = parseInt(navigator.appVersion);
  this.minor = parseFloat(navigator.appVersion);
  // DOM Support
  if (document.addEventListener && document.removeEventListener) this.dom2events = true;
  if (document.getElementById) this.dom1getbyid = true;
  // Opera
  this.opera = this.ua.indexOf('opera') != -1;
  if (this.opera) {
    this.opera5 = (this.ua.indexOf("opera 5") != -1 || this.ua.indexOf("opera/5") != -1);
    this.opera6 = (this.ua.indexOf("opera 6") != -1 || this.ua.indexOf("opera/6") != -1);
    return;
  }
  // Konqueror
  this.konq = this.ua.indexOf('konqueror') != -1;
  // MSIE
  this.ie = this.ua.indexOf('msie') != -1;
  if (this.ie) {
    this.ie3 = this.major < 4;
    this.ie4 = (this.major == 4 && this.ua.indexOf('msie 5') == -1 && this.ua.indexOf('msie 6') == -1);
    this.ie4up = this.major >= 4;
    this.ie5 = (this.major == 4 && this.ua.indexOf('msie 5.0') != -1);
    this.ie5up = !this.ie3 && !this.ie4;
    this.ie6 = (this.major == 4 && this.ua.indexOf('msie 6.0') != -1);
    this.ie6up = (!this.ie3 && !this.ie4 && !this.ie5 && this.ua.indexOf("msie 5.5") == -1);
    return;
  }
  // Misc.
  this.hotjava = this.ua.indexOf('hotjava') != -1;
  this.webtv = this.ua.indexOf('webtv') != -1;
  this.aol = this.ua.indexOf('aol') != -1;
  if (this.hotjava || this.webtv || this.aol) return;
  // Gecko, NN4+, and NS6
  this.gecko = this.ua.indexOf('gecko') != -1;
  this.nav = (this.ua.indexOf('mozilla') != -1 && this.ua.indexOf('spoofer') == -1 && this.ua.indexOf('compatible') == -1);
  if (this.nav) {
    this.nav4  = this.major == 4;
    this.nav4up= this.major >= 4;
    this.nav5up= this.major >= 5;
    this.nav6  = this.major == 5;
    this.nav6up= this.nav5up;
  }
}
window.is = new ClientSnifferJr();
if (is.konq) is.gecko = true; // experimental support for Konqueror
if (is.aol) is.ie = true; // experimental support for AOL
// End cbe_core.js