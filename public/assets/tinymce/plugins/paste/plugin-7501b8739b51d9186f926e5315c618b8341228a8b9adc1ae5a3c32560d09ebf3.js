!function(p){"use strict";function u(e,t){return q.each(t,function(t){e=t.constructor===RegExp?e.replace(t,""):e.replace(t[0],t[1])}),e}function m(e){var n,t;return t=[/^[IVXLMCD]{1,2}\.[ \u00a0]/,/^[ivxlmcd]{1,2}\.[ \u00a0]/,/^[a-z]{1,2}[\.\)][ \u00a0]/,/^[A-Z]{1,2}[\.\)][ \u00a0]/,/^[0-9]+\.[ \u00a0]/,/^[\u3007\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d]+\.[ \u00a0]/,/^[\u58f1\u5f10\u53c2\u56db\u4f0d\u516d\u4e03\u516b\u4e5d\u62fe]+\.[ \u00a0]/],e=e.replace(/^[\u00a0 ]+/,""),q.each(t,function(t){if(t.test(e))return!(n=!0)}),n}function c(t){function n(t){var e="";if(3===t.type)return t.value;if(t=t.firstChild)for(;e+=n(t),t=t.next;);return e}function i(t,e){if(3===t.type&&e.test(t.value))return t.value=t.value.replace(e,""),!1;if(t=t.firstChild)do{if(!i(t,e))return!1}while(t=t.next);return!0}function e(t,e,n){var r=t._listLevel||u;r!==u&&(r<u?a&&(a=a.parent.parent):(s=a,a=null)),a&&a.name===e?a.append(t):(s=s||a,a=new at(e,1),1<n&&a.attr("start",""+n),t.wrap(a)),t.name="li",u<r&&s&&s.lastChild.append(a),u=r,function o(t){if(t._listIgnore)t.remove();else if(t=t.firstChild)for(;o(t),t=t.next;);}(t),i(t,/^\u00a0+/),i(t,/^\s*([\u2022\u00b7\u00a7\u25CF]|\w+\.)/),i(t,/^\u00a0+/)}for(var a,s,u=1,r=[],o=t.firstChild;null!=o;)if(r.push(o),null!==(o=o.walk()))for(;void 0!==o&&o.parent!==t;)o=o.walk();for(var c=0;c<r.length;c++)if("p"===(t=r[c]).name&&t.firstChild){var l=n(t);if(/^[\s\u00a0]*[\u2022\u00b7\u00a7\u25CF]\s*/.test(l)){e(t,"ul");continue}if(m(l)){var f=/([0-9]+)\./.exec(l),d=1;f&&(d=parseInt(f[1],10)),e(t,"ol",d);continue}if(t._listLevel){e(t,"ul",1);continue}a=null}else s=a,a=null}function l(n,r,o,i){var a,s={},t=n.dom.parseStyle(i);return q.each(t,function(t,e){switch(e){case"mso-list":(a=/\w+ \w+([0-9]+)/i.exec(i))&&(o._listLevel=parseInt(a[1],10)),/Ignore/i.test(t)&&o.firstChild&&(o._listIgnore=!0,o.firstChild._listIgnore=!0);break;case"horiz-align":e="text-align";break;case"vert-align":e="vertical-align";break;case"font-color":case"mso-foreground":e="color";break;case"mso-background":case"mso-highlight":e="background";break;case"font-weight":case"font-style":return void("normal"!==t&&(s[e]=t));case"mso-element":if(/^(comment|comment-list)$/i.test(t))return void o.remove()}0!==e.indexOf("mso-comment")?0!==e.indexOf("mso-")&&("all"===ct.getRetainStyleProps(n)||r&&r[e])&&(s[e]=t):o.remove()}),/(bold)/i.test(s["font-weight"])&&(delete s["font-weight"],o.wrap(new at("b",1))),/(italic)/i.test(s["font-style"])&&(delete s["font-style"],o.wrap(new at("i",1))),(s=n.dom.serializeStyle(s,o.name))||null}function e(e,n){e.on("PastePreProcess",function(t){t.content=n(e,t.content,t.internal,t.wordContent)})}function n(t,e){if(!ft.isWordContent(e))return e;var n=[];q.each(t.schema.getBlockElements(),function(t,e){n.push(e)});var r=new RegExp("(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*(<\\/?("+n.join("|")+")[^>]*>)(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*","g");return e=lt.filter(e,[[r,"$1"]]),lt.filter(e,[[/<br><br>/g,"<BR><BR>"],[/<br>/g," "],[/<BR><BR>/g,"<br>"]])}function o(t,e,n,r){if(r||n)return e;var c,o=ct.getWebkitStyles(t);if(!1===ct.shouldRemoveWebKitStyles(t)||"all"===o)return e;if(o&&(c=o.split(/[, ]/)),c){var l=t.dom,f=t.selection.getNode();e=e.replace(/(<[^>]+) style="([^"]*)"([^>]*>)/gi,function(t,e,n,r){var o=l.parseStyle(l.decode(n)),i={};if("none"===c)return e+r;for(var a=0;a<c.length;a++){var s=o[c[a]],u=l.getStyle(f,c[a],!0);/color/.test(c[a])&&(s=l.toHex(s),u=l.toHex(u)),u!==s&&(i[c[a]]=s)}return(i=l.serializeStyle(i,"span"))?e+' style="'+i+'"'+r:e+r})}else e=e.replace(/(<[^>]+) style="([^"]*)"([^>]*>)/gi,"$1$3");return e.replace(/(<[^>]+) data-mce-style="([^"]+)"([^>]*>)/gi,function(t,e,n,r){return e+' style="'+n+'"'+r})}function i(n,t){n.$("a",t).find("font,u").each(function(t,e){n.dom.remove(e,!0)})}var t,r,a,s,f,g=function(t){var e=t,n=function(){return e};return{get:n,set:function(t){e=t},clone:function(){return g(n())}}},d=tinymce.util.Tools.resolve("tinymce.PluginManager"),v=function(t){return!(!/(^|[ ,])powerpaste([, ]|$)/.test(t.settings.plugins)||!d.get("powerpaste")||("undefined"!=typeof p.window.console&&p.window.console.log&&p.window.console.log("PowerPaste is incompatible with Paste plugin! Remove 'paste' from the 'plugins' option."),0))},h=function(t,e){return{clipboard:t,quirks:e}},y=function(t,e,n,r){return t.fire("PastePreProcess",{content:e,internal:n,wordContent:r})},b=function(t,e,n,r){return t.fire("PastePostProcess",{node:e,internal:n,wordContent:r})},x=function(t,e){return t.fire("PastePlainTextToggle",{state:e})},P=function(t,e){return t.fire("paste",{ieFake:e})},w=function(t,e){"text"===e.pasteFormat.get()?(e.pasteFormat.set("html"),x(t,!1)):(e.pasteFormat.set("text"),x(t,!0)),t.focus()},_=function(t,n){t.addCommand("mceTogglePlainTextPaste",function(){w(t,n)}),t.addCommand("mceInsertClipboardContent",function(t,e){e.content&&n.pasteHtml(e.content,e.internal),e.text&&n.pasteText(e.text)})},T=function(t){return function(){return t}},D=T(!1),C=T(!0),k=D,S=C,O=function(){return A},A=(s={fold:function(t){return t()},is:k,isSome:k,isNone:S,getOr:a=function(t){return t},getOrThunk:r=function(t){return t()},getOrDie:function(t){throw new Error(t||"error: getOrDie called on none.")},getOrNull:function(){return null},getOrUndefined:function(){return undefined},or:a,orThunk:r,map:O,ap:O,each:function(){},bind:O,flatten:O,exists:k,forall:S,filter:O,equals:t=function(t){return t.isNone()},equals_:t,toArray:function(){return[]},toString:T("none()")},Object.freeze&&Object.freeze(s),s),R=function(n){var t=function(){return n},e=function(){return o},r=function(t){return t(n)},o={fold:function(t,e){return e(n)},is:function(t){return n===t},isSome:S,isNone:k,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:e,orThunk:e,map:function(t){return R(t(n))},ap:function(t){return t.fold(O,function(t){return R(t(n))})},each:function(t){t(n)},bind:r,flatten:t,exists:r,forall:r,filter:function(t){return t(n)?o:A},equals:function(t){return t.is(n)},equals_:function(t,e){return t.fold(k,function(t){return e(n,t)})},toArray:function(){return[n]},toString:function(){return"some("+n+")"}};return o},E={some:R,none:O,from:function(t){return null===t||t===undefined?A:R(t)}},F=(f="function",function(t){return function(t){if(null===t)return"null";var e=typeof t;return"object"===e&&(Array.prototype.isPrototypeOf(t)||t.constructor&&"Array"===t.constructor.name)?"array":"object"===e&&(String.prototype.isPrototypeOf(t)||t.constructor&&"String"===t.constructor.name)?"string":e}(t)===f}),I=Array.prototype.slice,M=function(t,e){for(var n=t.length,r=new Array(n),o=0;o<n;o++){var i=t[o];r[o]=e(i,o,t)}return r},B=function(t,e){for(var n=0,r=t.length;n<r;n++)e(t[n],n,t)},H=F(Array.from)?Array.from:function(t){return I.call(t)},j=function(t){var n=E.none(),e=[],r=function(t){o()?a(t):e.push(t)},o=function(){return n.isSome()},i=function(t){B(t,a)},a=function(e){n.each(function(t){p.setTimeout(function(){e(t)},0)})};return t(function(t){n=E.some(t),i(e),e=[]}),{get:r,map:function(n){return j(function(e){r(function(t){e(n(t))})})},isReady:o}},L={nu:j,pure:function(e){return j(function(t){t(e)})}},N=function(e){var o=function(t){var r;e((r=t,function(){for(var t=[],e=0;e<arguments.length;e++)t[e]=arguments[e];var n=this;p.setTimeout(function(){r.apply(n,t)},0)}))},n=function(){return L.nu(o)};return{map:function(r){return N(function(n){o(function(t){var e=r(t);n(e)})})},bind:function(n){return N(function(e){o(function(t){n(t).get(e)})})},anonBind:function(e){return N(function(t){o(function(){e.get(t)})})},toLazy:n,toCached:function(){var e=null;return N(function(t){null===e&&(e=n()),e.get(t)})},get:o}},$={nu:N,pure:function(e){return N(function(t){t(e)})}},W=function(a,t){return t(function(r){var o=[],i=0;0===a.length?r([]):B(a,function(t,e){var n;t.get((n=e,function(t){o[n]=t,++i>=a.length&&r(o)}))})})},z=function(t,e){var n=M(t,e);return W(n,$.nu)},U=tinymce.util.Tools.resolve("tinymce.Env"),V=tinymce.util.Tools.resolve("tinymce.util.Delay"),q=tinymce.util.Tools.resolve("tinymce.util.Tools"),K=tinymce.util.Tools.resolve("tinymce.util.VK"),G="x-tinymce/html",X="<!-- "+G+" -->",Y=function(t){return X+t},Z=function(t){return t.replace(X,"")},J=function(t){return-1!==t.indexOf(X)},Q=function(){return G},tt=tinymce.util.Tools.resolve("tinymce.html.Entities"),et=function(t){return t.replace(/\r?\n/g,"<br>")},nt=function(t,i,e){var n=t.split(/\n\n/),r=function(t,e){var n,r=[],o="<"+i;if("object"==typeof e){for(n in e)e.hasOwnProperty(n)&&r.push(n+'="'+tt.encodeAllRaw(e[n])+'"');r.length&&(o+=" "+r.join(" "))}return o+">"}(0,e),o="</"+i+">",a=q.map(n,function(t){return t.split(/\n/).join("<br />")});return 1===a.length?a[0]:q.map(a,function(t){return r+t+o}).join("")},rt=function(t){return!/<(?:\/?(?!(?:div|p|br|span)>)\w+|(?:(?!(?:span style="white-space:\s?pre;?">)|br\s?\/>))\w+\s[^>]+)>/i.test(t)},ot=function(t,e,n){return e?nt(t,!0===e?"p":e,n):et(t)},it=tinymce.util.Tools.resolve("tinymce.html.DomParser"),at=tinymce.util.Tools.resolve("tinymce.html.Node"),st=tinymce.util.Tools.resolve("tinymce.html.Schema"),ut=tinymce.util.Tools.resolve("tinymce.html.Serializer"),ct={shouldBlockDrop:function(t){return t.getParam("paste_block_drop",!1)},shouldPasteDataImages:function(t){return t.getParam("paste_data_images",!1)},shouldFilterDrop:function(t){return t.getParam("paste_filter_drop",!0)},getPreProcess:function(t){return t.getParam("paste_preprocess")},getPostProcess:function(t){return t.getParam("paste_postprocess")},getWebkitStyles:function(t){return t.getParam("paste_webkit_styles")},shouldRemoveWebKitStyles:function(t){return t.getParam("paste_remove_styles_if_webkit",!0)},shouldMergeFormats:function(t){return t.getParam("paste_merge_formats",!0)},isSmartPasteEnabled:function(t){return t.getParam("smart_paste",!0)},isPasteAsTextEnabled:function(t){return t.getParam("paste_as_text",!1)},getRetainStyleProps:function(t){return t.getParam("paste_retain_style_properties")},getWordValidElements:function(t){return t.getParam("paste_word_valid_elements","-strong/b,-em/i,-u,-span,-p,-ol,-ul,-li,-h1,-h2,-h3,-h4,-h5,-h6,-p/div,-a[href|name],sub,sup,strike,br,del,table[width],tr,td[colspan|rowspan|width],th[colspan|rowspan|width],thead,tfoot,tbody")},shouldConvertWordFakeLists:function(t){return t.getParam("paste_convert_word_fake_lists",!0)},shouldUseDefaultFilters:function(t){return t.getParam("paste_enable_default_filters",!0)}},lt={filter:u,innerText:function te(t){var e=st(),n=it({},e),r="",o=e.getShortEndedElements(),i=q.makeMap("script noscript style textarea video audio iframe object"," "),a=e.getBlockElements();return t=u(t,[/<!\[[^\]]+\]>/g]),function s(t){var e=t.name,n=t;if("br"!==e){if("wbr"!==e)if(o[e]&&(r+=" "),i[e])r+=" ";else{if(3===t.type&&(r+=t.value),!t.shortEnded&&(t=t.firstChild))for(;s(t),t=t.next;);a[e]&&n.next&&(r+="\n","p"===e&&(r+="\n"))}}else r+="\n"}(n.parse(t)),r},trimHtml:function ee(t){return u(t,[/^[\s\S]*<body[^>]*>\s*|\s*<\/body[^>]*>[\s\S]*$/gi,/<!--StartFragment-->|<!--EndFragment-->/g,[/( ?)<span class="Apple-converted-space">\u00a0<\/span>( ?)/g,function r(t,e,n){return e||n?"\xa0":" "}],/<br class="Apple-interchange-newline">/g,/<br>$/i])},createIdGenerator:function ne(t){var e=0;return function(){return t+e++}},isMsEdge:function(){return-1!==p.navigator.userAgent.indexOf(" Edge/")}},ft={preProcess:function(t,e){return ct.shouldUseDefaultFilters(t)?function(r,t){var e,o;(e=ct.getRetainStyleProps(r))&&(o=q.makeMap(e.split(/[, ]/))),t=lt.filter(t,[/<br class="?Apple-interchange-newline"?>/gi,/<b[^>]+id="?docs-internal-[^>]*>/gi,/<!--[\s\S]+?-->/gi,/<(!|script[^>]*>.*?<\/script(?=[>\s])|\/?(\?xml(:\w+)?|img|meta|link|style|\w:\w+)(?=[\s\/>]))[^>]*>/gi,[/<(\/?)s>/gi,"<$1strike>"],[/&nbsp;/gi,"\xa0"],[/<span\s+style\s*=\s*"\s*mso-spacerun\s*:\s*yes\s*;?\s*"\s*>([\s\u00a0]*)<\/span>/gi,function(t,e){return 0<e.length?e.replace(/./," ").slice(Math.floor(e.length/2)).split("").join("\xa0"):""}]]);var n=ct.getWordValidElements(r),i=st({valid_elements:n,valid_children:"-li[p]"});q.each(i.elements,function(t){t.attributes["class"]||(t.attributes["class"]={},t.attributesOrder.push("class")),t.attributes.style||(t.attributes.style={},t.attributesOrder.push("style"))});var a=it({},i);a.addAttributeFilter("style",function(t){for(var e,n=t.length;n--;)(e=t[n]).attr("style",l(r,o,e,e.attr("style"))),"span"===e.name&&e.parent&&!e.attributes.length&&e.unwrap()}),a.addAttributeFilter("class",function(t){for(var e,n,r=t.length;r--;)n=(e=t[r]).attr("class"),/^(MsoCommentReference|MsoCommentText|msoDel)$/i.test(n)&&e.remove(),e.attr("class",null)}),a.addNodeFilter("del",function(t){for(var e=t.length;e--;)t[e].remove()}),a.addNodeFilter("a",function(t){for(var e,n,r,o=t.length;o--;)if(n=(e=t[o]).attr("href"),r=e.attr("name"),n&&-1!==n.indexOf("#_msocom_"))e.remove();else if(n&&0===n.indexOf("file://")&&(n=n.split("#")[1])&&(n="#"+n),n||r){if(r&&!/^_?(?:toc|edn|ftn)/i.test(r)){e.unwrap();continue}e.attr({href:n,name:r})}else e.unwrap()});var s=a.parse(t);return ct.shouldConvertWordFakeLists(r)&&c(s),ut({validate:r.settings.validate},i).serialize(s)}(t,e):e},isWordContent:function re(t){return/<font face="Times New Roman"|class="?Mso|style="[^"]*\bmso-|style='[^'']*\bmso-|w:WordDocument/i.test(t)||/class="OutlineElement/.test(t)||/id="?docs\-internal\-guid\-/.test(t)}},dt=function(t,e){return{content:t,cancelled:e}},mt=function(t,e,n,r){var o,i,a,s,u,c,l=y(t,e,n,r);return t.hasEventListeners("PastePostProcess")&&!l.isDefaultPrevented()?(o=t,i=l.content,a=n,s=r,u=o.dom.create("div",{style:"display:none"},i),c=b(o,u,a,s),dt(c.node.innerHTML,c.isDefaultPrevented())):dt(l.content,l.isDefaultPrevented())},gt=function(t,e,n){var r=ft.isWordContent(e),o=r?ft.preProcess(t,e):e;return mt(t,o,n,r)},pt=function(t,e){var n,r;return t.insertContent((n=e,r=t.dom.create("body",{},n),q.each(r.querySelectorAll("meta"),function(t){return t.parentNode.removeChild(t)}),r.innerHTML),{merge:ct.shouldMergeFormats(t),paste:!0}),!0},vt=function(t){return/^https?:\/\/[\w\?\-\/+=.&%@~#]+$/i.test(t)},ht=function(t){return vt(t)&&/.(gif|jpe?g|png)$/.test(t)},yt=function(t,e,n){return!(!1!==t.selection.isCollapsed()||!vt(e)||(o=e,i=n,(r=t).undoManager.extra(function(){i(r,o)},function(){r.execCommand("mceInsertLink",!1,o)}),0));var r,o,i},bt=function(t,e,n){return!!ht(e)&&(o=e,i=n,(r=t).undoManager.extra(function(){i(r,o)},function(){r.insertContent('<img src="'+o+'">')}),!0);var r,o,i},xt=function(t,e){var n,r;!1===ct.isSmartPasteEnabled(t)?pt(t,e):(n=t,r=e,q.each([yt,bt,pt],function(t){return!0!==t(n,r,pt)}))},Pt=function(t){return"\n"===t||"\r"===t},wt=function(o){var e,n;return(n={pcIsSpace:(e=function(t,e){return-1!==" \f\t\x0B".indexOf(e)||"\xa0"===e?t.pcIsSpace||""===t.str||t.str.length===o.length-1||(n=o,(r=t.str.length+1)<n.length&&0<=r&&Pt(n[r]))?{pcIsSpace:!1,str:t.str+"\xa0"}:{pcIsSpace:!0,str:t.str+" "}:{pcIsSpace:Pt(e),str:t.str+e};var n,r},!1),str:""},B(o,function(t){n=e(n,t)}),n).str},_t=function(t,e,n){var r=n||J(e),o=gt(t,Z(e),r);!1===o.cancelled&&xt(t,o.content)},Tt=function(t,e){var n=t.dom.encode(e).replace(/\r\n/g,"\n"),r=wt(n),o=ot(r,t.settings.forced_root_block,t.settings.forced_root_block_attrs);_t(t,o,!1)},Dt=function(t){var e={};if(t){if(t.getData){var n=t.getData("Text");n&&0<n.length&&-1===n.indexOf("data:text/mce-internal,")&&(e["text/plain"]=n)}if(t.types)for(var r=0;r<t.types.length;r++){var o=t.types[r];try{e[o]=t.getData(o)}catch(g){e[o]=""}}}return e},Ct=function(t,e){return e in t&&0<t[e].length},kt=function(t){return Ct(t,"text/html")||Ct(t,"text/plain")},St=lt.createIdGenerator("mceclip"),Ot=function(e,t,n){var r,o,i,a,s="paste"===t.type?t.clipboardData:t.dataTransfer;if(e.settings.paste_data_images&&s){var u=(i=(o=s).items?M(H(o.items),function(t){return t.getAsFile()}):[],a=o.files?H(o.files):[],function(t,e){for(var n=[],r=0,o=t.length;r<o;r++){var i=t[r];e(i,r,t)&&n.push(i)}return n}(0<i.length?i:a,function(t){return/^image\/(jpeg|png|gif|bmp)$/.test(t.type)}));if(0<u.length)return t.preventDefault(),(r=u,z(r,function(r){return $.nu(function(t){var e=r.getAsFile?r.getAsFile():r,n=new window.FileReader;n.onload=function(){t({blob:e,uri:n.result})},n.readAsDataURL(e)})})).get(function(t){n&&e.selection.setRng(n),B(t,function(t){!function(t,e){var n,r,o,i,a,s,u=-1!==(r=(n=e.uri).indexOf(","))?n.substr(r+1):null,c=St(),l=t.settings.images_reuse_filename&&e.blob.name?(o=t,(i=e.blob.name.match(/([\s\S]+?)\.(?:jpeg|jpg|png|gif)$/i))?o.dom.encode(i[1]):null):c,f=new p.Image;if(f.src=e.uri,s=f,!(a=t.settings).images_dataimg_filter||a.images_dataimg_filter(s)){var d,m=t.editorUpload.blobCache,g=void 0;(d=m.findFirst(function(t){return t.base64()===u}))?g=d:(g=m.create(c,e.blob,u,l),m.add(g)),_t(t,'<img src="'+g.blobUri()+'">',!1)}else _t(t,'<img src="'+e.uri+'">',!1)}(e,t)})}),!0}return!1},At=function(t){return K.metaKeyPressed(t)&&86===t.keyCode||t.shiftKey&&45===t.keyCode},Rt=function(u,c,l){function f(t,e,n,r){var o,i;Ct(t,"text/html")?o=t["text/html"]:(o=c.getHtml(),r=r||J(o),c.isDefaultContent(o)&&(n=!0)),o=lt.trimHtml(o),c.remove(),i=!1===r&&rt(o),o.length&&!i||(n=!0),n&&(o=Ct(t,"text/plain")&&i?t["text/plain"]:lt.innerText(o)),c.isDefaultContent(o)?e||u.windowManager.alert("Please use Ctrl+V/Cmd+V keyboard shortcuts to paste contents."):n?Tt(u,o):_t(u,o,r)}var e,d,m=(e=g(E.none()),{clear:function(){e.set(E.none())},set:function(t){e.set(E.some(t))},isSet:function(){return e.get().isSome()},on:function(t){e.get().each(t)}});u.on("keydown",function(t){function e(t){At(t)&&!t.isDefaultPrevented()&&c.remove()}if(At(t)&&!t.isDefaultPrevented()){if((d=t.shiftKey&&86===t.keyCode)&&U.webkit&&-1!==p.navigator.userAgent.indexOf("Version/"))return;if(t.stopImmediatePropagation(),m.set(t),window.setTimeout(function(){m.clear()},100),U.ie&&d)return t.preventDefault(),void P(u,!0);c.remove(),c.create(),u.once("keyup",e),u.once("paste",function(){u.off("keyup",e)})}}),u.on("paste",function(t){var e,n,r,o=m.isSet(),i=(e=u,n=Dt(t.clipboardData||e.getDoc().dataTransfer),lt.isMsEdge()?q.extend(n,{"text/html":""}):n),a="text"===l.get()||d,s=Ct(i,Q());d=!1,t.isDefaultPrevented()||(r=t.clipboardData,-1!==p.navigator.userAgent.indexOf("Android")&&r&&r.items&&0===r.items.length)?c.remove():kt(i)||!Ot(u,t,c.getLastRng()||u.selection.getRng())?(o||t.preventDefault(),!U.ie||o&&!t.ieFake||Ct(i,"text/html")||(c.create(),u.dom.bind(c.getEl(),"paste",function(t){t.stopPropagation()}),u.getDoc().execCommand("Paste",!1,null),i["text/html"]=c.getHtml()),Ct(i,"text/html")?(t.preventDefault(),s||(s=J(i["text/html"])),f(i,o,a,s)):V.setEditorTimeout(u,function(){f(i,o,a,s)},0)):c.remove()})},Et=function(t){return U.ie&&t.inline?p.document.body:t.getBody()},Ft=function(t,e,n){var r;Et(r=t)!==r.getBody()&&t.dom.bind(e,"paste keyup",function(){Bt(t,n)||t.fire("paste")})},It=function(t){return t.dom.get("mcepastebin")},Mt=function(t,e){return e===t},Bt=function(t,e){var n,r=It(t);return(n=r)&&"mcepastebin"===n.id&&Mt(e,r.innerHTML)},Ht=function(a){var s=g(null),u="%MCEPASTEBIN%";return{create:function(){return e=s,n=u,o=(t=a).dom,i=t.getBody(),e.set(t.selection.getRng()),r=t.dom.add(Et(t),"div",{id:"mcepastebin","class":"mce-pastebin",contentEditable:!0,"data-mce-bogus":"all",style:"position: fixed; top: 50%; width: 10px; height: 10px; overflow: hidden; opacity: 0"},n),(U.ie||U.gecko)&&o.setStyle(r,"left","rtl"===o.getStyle(i,"direction",!0)?65535:-65535),o.bind(r,"beforedeactivate focusin focusout",function(t){t.stopPropagation()}),Ft(t,r,n),r.focus(),void t.selection.select(r,!0);var t,e,n,r,o,i},remove:function(){return function(t,e){if(It(t)){for(var n=void 0,r=e.get();n=t.dom.get("mcepastebin");)t.dom.remove(n),t.dom.unbind(n);r&&t.selection.setRng(r)}e.set(null)}(a,s)},getEl:function(){return It(a)},getHtml:function(){return function(n){var e,t,r,o,i,a=function(t,e){t.appendChild(e),n.dom.remove(e,!0)};for(t=q.grep(Et(n).childNodes,function(t){return"mcepastebin"===t.id}),e=t.shift(),q.each(t,function(t){a(e,t)}),r=(o=n.dom.select("div[id=mcepastebin]",e)).length-1;0<=r;r--)i=n.dom.create("div"),e.insertBefore(i,o[r]),a(i,o[r]);return e?e.innerHTML:""}(a)},getLastRng:function(){return s.get()},isDefault:function(){return Bt(a,u)},isDefaultContent:function(t){return Mt(u,t)}}},jt=function(n,t){var e=Ht(n);return n.on("PreInit",function(){return Rt(a=n,e,t),void a.parser.addNodeFilter("img",function(t,e,n){var r,o=function(t){t.attr("data-mce-object")||s===U.transparentSrc||t.remove()};if(!a.settings.paste_data_images&&(r=n).data&&!0===r.data.paste)for(var i=t.length;i--;)(s=t[i].attr("src"))&&(0===s.indexOf("webkit-fake-url")?o(t[i]):a.settings.allow_html_data_urls||0!==s.indexOf("data:")||o(t[i]))});var a,s}),{pasteFormat:t,pasteHtml:function(t,e){return _t(n,t,e)},pasteText:function(t){return Tt(n,t)},pasteImageData:function(t,e){return Ot(n,t,e)},getDataTransferItems:Dt,hasHtmlOrText:kt,hasContentType:Ct}},Lt=function(){},Nt=function(t,e,n){if(r=t,!1!==U.iOS||r===undefined||"function"!=typeof r.setData||!0===lt.isMsEdge())return!1;try{return t.clearData(),t.setData("text/html",e),t.setData("text/plain",n),t.setData(Q(),e),!0}catch(f){return!1}var r},$t=function(t,e,n,r){Nt(t.clipboardData,e.html,e.text)?(t.preventDefault(),r()):n(e.html,r)},Wt=function(s){return function(t,e){var n=Y(t),r=s.dom.create("div",{contenteditable:"false","data-mce-bogus":"all"}),o=s.dom.create("div",{contenteditable:"true"},n);s.dom.setStyles(r,{position:"fixed",top:"0",left:"-3000px",width:"1000px",overflow:"hidden"}),r.appendChild(o),s.dom.add(s.getBody(),r);var i=s.selection.getRng();o.focus();var a=s.dom.createRng();a.selectNodeContents(o),s.selection.setRng(a),V.setTimeout(function(){s.selection.setRng(i),r.parentNode.removeChild(r),e()},0)}},zt=function(t){return{html:t.selection.getContent({contextual:!0}),text:t.selection.getContent({format:"text"})}},Ut=function(t){return!t.selection.isCollapsed()||!!(e=t).dom.getParent(e.selection.getStart(),"td[data-mce-selected],th[data-mce-selected]",e.getBody());var e},Vt=function(t){var e,n;t.on("cut",(e=t,function(t){Ut(e)&&$t(t,zt(e),Wt(e),function(){V.setTimeout(function(){e.execCommand("Delete")},0)})})),t.on("copy",(n=t,function(t){Ut(n)&&$t(t,zt(n),Wt(n),Lt)}))},qt=tinymce.util.Tools.resolve("tinymce.dom.RangeUtils"),Kt=function(t,e){return qt.getCaretRangeFromPoint(e.clientX,e.clientY,t.getDoc())},Gt=function(t,e){t.focus(),t.selection.setRng(e)},Xt=function(a,s,u){ct.shouldBlockDrop(a)&&a.on("dragend dragover draggesture dragdrop drop drag",function(t){t.preventDefault(),t.stopPropagation()}),ct.shouldPasteDataImages(a)||a.on("drop",function(t){var e=t.dataTransfer;e&&e.files&&0<e.files.length&&t.preventDefault()}),a.on("drop",function(t){var e,n;if(n=Kt(a,t),!t.isDefaultPrevented()&&!u.get()){e=s.getDataTransferItems(t.dataTransfer);var r,o=s.hasContentType(e,Q());if((s.hasHtmlOrText(e)&&(!(r=e["text/plain"])||0!==r.indexOf("file://"))||!s.pasteImageData(t,n))&&n&&ct.shouldFilterDrop(a)){var i=e["mce-internal"]||e["text/html"]||e["text/plain"];i&&(t.preventDefault(),V.setEditorTimeout(a,function(){a.undoManager.transact(function(){e["mce-internal"]&&a.execCommand("Delete"),Gt(a,n),i=lt.trimHtml(i),e["text/html"]?s.pasteHtml(i,o):s.pasteText(i)})}))}}}),a.on("dragstart",function(){u.set(!0)}),a.on("dragover dragend",function(t){ct.shouldPasteDataImages(a)&&!1===u.get()&&(t.preventDefault(),Gt(a,Kt(a,t))),"dragend"===t.type&&u.set(!1)})},Yt=function(t){var e=t.plugins.paste,n=ct.getPreProcess(t);n&&t.on("PastePreProcess",function(t){n.call(e,e,t)});var r=ct.getPostProcess(t);r&&t.on("PastePostProcess",function(t){r.call(e,e,t)})},Zt=function(t){U.webkit&&e(t,o),U.ie&&(e(t,n),function r(e,n){e.on("PastePostProcess",function(t){n(e,t.node)})}(t,i))},Jt=function(n,r){return function(e){e.setActive("text"===r.pasteFormat.get());var t=function(t){return e.setActive(t.state)};return n.on("PastePlainTextToggle",t),function(){return n.off("PastePlainTextToggle",t)}}},Qt=function(t,e){t.ui.registry.addToggleButton("pastetext",{active:!1,icon:"paste-text",tooltip:"Paste as text",onAction:function(){return t.execCommand("mceTogglePlainTextPaste")},onSetup:Jt(t,e)}),t.ui.registry.addToggleMenuItem("pastetext",{text:"Paste as text",onAction:function(){return t.execCommand("mceTogglePlainTextPaste")},onSetup:Jt(t,e)})};!function oe(){d.add("paste",function(t){if(!1===v(t)){var e=g(!1),n=g(ct.isPasteAsTextEnabled(t)?"text":"html"),r=jt(t,n),o=Zt(t);return Qt(t,r),_(t,r),Yt(t),Vt(t),Xt(t,r,e),h(r,o)}})}()}(window);