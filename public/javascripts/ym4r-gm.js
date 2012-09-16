// JS helper functions for YM4R

function addInfoWindowToMarker(marker,info,options){
  GEvent.addListener(marker, "click", function() {marker.openInfoWindowHtml(info,options);});
  return marker;
}

function addInfoWindowTabsToMarker(marker,info,options){
     GEvent.addListener(marker, "click", function() {marker.openInfoWindowTabsHtml(info,options);});
     return marker;
}

function addPropertiesToLayer(layer,getTile,copyright,opacity,isPng){
    layer.getTileUrl = getTile;
    layer.getCopyright = copyright;
    layer.getOpacity = opacity;
    layer.isPng = isPng;
    return layer;
}

function addOptionsToIcon(icon,options){
    for(var k in options){
  icon[k] = options[k];
    }
    return icon;
}

function addCodeToFunction(func,code){
    if(func == undefined)
  return code;
    else{
  return function(){
      func();
      code();
  }
    }
}

function addGeocodingToMarker(marker,address){
    marker.orig_initialize = marker.initialize;
    orig_redraw = marker.redraw;
    marker.redraw = function(force){}; //empty the redraw method so no error when called by addOverlay.
    marker.initialize = function(map){
  new GClientGeocoder().getLatLng(address,
          function(latlng){
      if(latlng){
    marker.redraw = orig_redraw;
    marker.orig_initialize(map); //init before setting point
    marker.setPoint(latlng);
      }//do nothing
  });
    };
    return marker;
}



GMap2.prototype.centerAndZoomOnMarkers = function(markers) {
     var bounds = new GLatLngBounds(markers[0].getPoint(),
            markers[0].getPoint());
     for (var i=1, len = markers.length ; i<len; i++) {
   bounds.extend(markers[i].getPoint());
     }

     this.centerAndZoomOnBounds(bounds);
 }

GMap2.prototype.centerAndZoomOnPoints = function(points) {
     var bounds = new GLatLngBounds(points[0],
            points[0]);
     for (var i=1, len = points.length ; i<len; i++) {
   bounds.extend(points[i]);
     }

     this.centerAndZoomOnBounds(bounds);
 }

GMap2.prototype.centerAndZoomOnBounds = function(bounds) {
    var center = bounds.getCenter();
    this.setCenter(center, this.getBoundsZoomLevel(bounds));
}

//For full screen mode
function setWindowDims(elem) {
    if (window.innerWidth){
  elem.style.height = (window.innerHeight) + 'px;';
  elem.style.width = (window.innerWidth) + 'px;';
    }else if (document.body.clientWidth){
  elem.style.width = (document.body.clientWidth) + 'px';
  elem.style.height = (document.body.clientHeight) + 'px';
    }
}

ManagedMarker = function(markers,minZoom,maxZoom) {
    this.markers = markers;
    this.minZoom = minZoom;
    this.maxZoom = maxZoom;
}

//Add the markers and refresh
function addMarkersToManager(manager,managedMarkers){
    for(var i = 0, length = managedMarkers.length; i < length;i++) {
  mm = managedMarkers[i];
  manager.addMarkers(mm.markers,mm.minZoom,mm.maxZoom);
    }
    manager.refresh();
    return manager;
}


var INVISIBLE = new GLatLng(0,0); //almost always invisible

if(self.Event && Event.observe){
    Event.observe(window, 'unload', GUnload);
}else{
    window.onunload = GUnload;
}

var mapdiv;
var mouselat;
var mouselng;

function zoom(a) {
        var m = map.fromLatLngToDivPixel(new GLatLng(mouselat,mouselng));
        var c = map.fromLatLngToDivPixel(map.getCenter());
        if (a == 'in') {
                var x = c.x - ((m.x - c.x) * -.5);
                var y = c.y - ((m.y - c.y) * -.5);
                var n = map.fromDivPixelToLatLng(new GPoint(x,y));
                map.setCenter(n);
                map.zoomIn();
        } else {
                var x = c.x - (m.x - c.x);
                var y = c.y - (m.y - c.y);
                var n = map.fromDivPixelToLatLng(new GPoint(x,y));
                map.setCenter(n);
                map.zoomOut();
        }
}
/*
        Zoom in/out when mouse wheel scrolls
*/
GMap2.prototype.wheelZoom = function(event) {
                if(window.event) {
                        var x = event.offsetX;
                        var y = event.offsetY;
                } else {
                        var x = event.layerX;
                        var y = event.layerY;
                }
                if (window.event) {
                        event.returnValue = false; // IE
                }
        if (event.cancelable) {
                event.preventDefault();  // DOM-Standard
        }
        if ((event.detail || -event.wheelDelta) < 0) {
                zoom('in');
        } else {
                zoom('out');
        }
        return false;
}

function hookMouseWheel(id) {
    mapdiv = document.getElementById(id);
    GEvent.addDomListener(mapdiv, "DOMMouseScroll", map.wheelZoom); // Firefox
    GEvent.addDomListener(mapdiv, "mousewheel", map.wheelZoom); // IE
    GEvent.addListener(map, "mousemove", function(point) {
                    mouselat = point.y.toFixed(6);
                    mouselng = point.x.toFixed(6);
            }
    );
}
