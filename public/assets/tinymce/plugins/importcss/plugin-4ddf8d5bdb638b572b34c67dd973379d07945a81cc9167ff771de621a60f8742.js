/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.12 (2019-07-18)
 */

!function(){"use strict";var t,e,n,r,o=tinymce.util.Tools.resolve("tinymce.PluginManager"),v=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),f=tinymce.util.Tools.resolve("tinymce.EditorManager"),m=tinymce.util.Tools.resolve("tinymce.Env"),d=tinymce.util.Tools.resolve("tinymce.util.Tools"),c=function(t){return t.getParam("importcss_merge_classes")},i=function(t){return t.getParam("importcss_exclusive")},h=function(t){return t.getParam("importcss_selector_converter")},l=function(t){return t.getParam("importcss_selector_filter")},p=function(t){return t.getParam("importcss_groups")},_=function(t){return t.getParam("importcss_append")},x=function(t){return t.getParam("importcss_file_filter")},u=function(t){return function(){return t}},s=u(!1),a=u(!0),g=function(){return y},y=(r={fold:function(t,e){return t()},is:s,isSome:s,isNone:a,getOr:n=function(t){return t},getOrThunk:e=function(t){return t()},getOrDie:function(t){throw new Error(t||"error: getOrDie called on none.")},getOrNull:function(){return null},getOrUndefined:function(){return undefined},or:n,orThunk:e,map:g,ap:g,each:function(){},bind:g,flatten:g,exists:s,forall:a,filter:g,equals:t=function(t){return t.isNone()},equals_:t,toArray:function(){return[]},toString:u("none()")},Object.freeze&&Object.freeze(r),r),O=function(e){return function(t){return function(t){if(null===t)return"null";var e=typeof t;return"object"===e&&(Array.prototype.isPrototypeOf(t)||t.constructor&&"Array"===t.constructor.name)?"array":"object"===e&&(String.prototype.isPrototypeOf(t)||t.constructor&&"String"===t.constructor.name)?"string":e}(t)===e}},T=O("array"),b=O("function"),k=Array.prototype.slice,S=Array.prototype.push,A=function(t,e){return function(t){for(var e=[],n=0,r=t.length;n<r;++n){if(!T(t[n]))throw new Error("Arr.flatten item "+n+" was not an array, input: "+t);S.apply(e,t[n])}return e}(function(t,e){for(var n=t.length,r=new Array(n),o=0;o<n;o++){var i=t[o];r[o]=e(i,o,t)}return r}(t,e))},P=(b(Array.from)&&Array.from,function(e){return"string"==typeof e?function(t){return-1!==t.indexOf(e)}:e instanceof RegExp?function(t){return e.test(t)}:e}),w=function(c,t,s){var a=[],n={};function l(t,e){var n,r,o,i=t.href;if(r=i,o=m.cacheSuffix,"string"==typeof r&&(r=r.replace("?"+o,"").replace("&"+o,"")),(i=r)&&s(i,e)&&!function(t,e){var n=t.settings,r=!1!==n.skin&&(n.skin||"oxide");if(r){var o=n.skin_url?t.documentBaseURI.toAbsolute(n.skin_url):f.baseURL+"/skins/ui/"+r,i=f.baseURL+"/skins/content/";return e===o+"/content"+(t.inline?".inline":"")+".min.css"||-1!==e.indexOf(i)}return!1}(c,i)){d.each(t.imports,function(t){l(t,!0)});try{n=t.cssRules||t.rules}catch(u){}d.each(n,function(t){t.styleSheet?l(t.styleSheet,!0):t.selectorText&&d.each(t.selectorText.split(","),function(t){a.push(d.trim(t))})})}}d.each(c.contentCSS,function(t){n[t]=!0}),s||(s=function(t,e){return e||n[t]});try{d.each(t.styleSheets,function(t){l(t)})}catch(e){}return a},E=function(t,e){var n,r=/^(?:([a-z0-9\-_]+))?(\.[a-z0-9_\-\.]+)$/i.exec(e);if(r){var o=r[1],i=r[2].substr(1).split(".").join(" "),u=d.makeMap("a,img");return r[1]?(n={title:e},t.schema.getTextBlockElements()[o]?n.block=o:t.schema.getBlockElements()[o]||u[o.toLowerCase()]?n.selector=o:n.inline=o):r[2]&&(n={inline:"span",title:e.substr(1),classes:i}),!1!==c(t)?n.classes=i:n.attributes={"class":i},n}},I=function(t,e){return null===e||!1!==i(t)},M=E,j=function(y){y.on("init",function(t){var e,n,r,o,i=(e=[],n=[],r={},{addItemToGroup:function(t,e){r[t]?r[t].push(e):(n.push(t),r[t]=[e])},addItem:function(t){e.push(t)},toFormats:function(){return A(n,function(t){var e=r[t];return 0===e.length?[]:[{title:t,items:e}]}).concat(e)}}),g={},u=P(l(y)),c=(o=p(y),d.map(o,function(t){return d.extend({},t,{original:t,selectors:{},filter:P(t.filter),item:{text:t.title,menu:[]}})})),s=function(t,e){if(f=t,p=g,!(I(y,m=e)?f in p:f in m.selectors)){s=t,l=g,I(y,a=e)?l[s]=!0:a.selectors[s]=!0;var n=(i=(o=y).plugins.importcss,u=t,((c=e)&&c.selector_converter?c.selector_converter:h(o)?h(o):function(){return E(o,u)}).call(i,u,c));if(n){var r=n.name||v.DOM.uniqueId();return y.formatter.register(r,n),d.extend({},{title:n.title,format:r})}}var o,i,u,c,s,a,l,f,m,p;return null};d.each(w(y,y.getDoc(),P(x(y))),function(n){if(-1===n.indexOf(".mce-")&&(!u||u(n))){var t=(r=c,o=n,d.grep(r,function(t){return!t.filter||t.filter(o)}));if(0<t.length)d.each(t,function(t){var e=s(n,t);e&&i.addItemToGroup(t.title,e)});else{var e=s(n,null);e&&i.addItem(e)}}var r,o});var a=i.toFormats();y.fire("addStyleModifications",{items:a,replace:!_(y)})})},D=function(e){return{convertSelectorToFormat:function(t){return M(e,t)}}};!function R(){o.add("importcss",function(t){return j(t),D(t)})}()}();