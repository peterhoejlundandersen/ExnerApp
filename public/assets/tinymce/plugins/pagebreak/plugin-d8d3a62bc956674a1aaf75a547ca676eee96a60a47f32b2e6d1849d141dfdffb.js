!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),n=tinymce.util.Tools.resolve("tinymce.Env"),a=function(e){return e.getParam("pagebreak_separator","<!-- pagebreak -->")},i=function(e){return e.getParam("pagebreak_split_block",!1)},t=function(){return'<img src="'+n.transparentSrc+'" class="mce-pagebreak" data-mce-resize="false" data-mce-placeholder />'},r=function(o){var c=a(o),n=new RegExp(c.replace(/[\?\.\*\[\]\(\)\{\}\+\^\$\:]/g,function(e){return"\\"+e}),"gi");o.on("BeforeSetContent",function(e){e.content=e.content.replace(n,t())}),o.on("PreInit",function(){o.serializer.addNodeFilter("img",function(e){for(var n,a,t=e.length;t--;)if((a=(n=e[t]).attr("class"))&&-1!==a.indexOf("mce-pagebreak")){var r=n.parent;if(o.schema.getBlockElements()[r.name]&&i(o)){r.type=3,r.value=c,r.raw=!0,n.remove();continue}n.type=3,n.value=c,n.raw=!0}})})},o=t,c=function(){return"mce-pagebreak"},u=function(e){e.addCommand("mcePageBreak",function(){e.settings.pagebreak_split_block?e.insertContent("<p>"+o()+"</p>"):e.insertContent(o())})},g=function(n){n.on("ResolveName",function(e){"IMG"===e.target.nodeName&&n.dom.hasClass(e.target,c())&&(e.name="pagebreak")})},m=function(e){e.ui.registry.addButton("pagebreak",{icon:"page-break",tooltip:"Page break",onAction:function(){return e.execCommand("mcePageBreak")}}),e.ui.registry.addMenuItem("pagebreak",{text:"Page break",icon:"page-break",onAction:function(){return e.execCommand("mcePageBreak")}})};!function s(){e.add("pagebreak",function(e){u(e),m(e),r(e),g(e)})}()}();