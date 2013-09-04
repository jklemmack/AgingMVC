<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<AgingMVC.Models.VideoModel>" %>
<div id="<%=Model.ID %>">
    Loading the player...
</div>
<%--<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,45,2"
    width="576" height="360" id="<%=Model.ID %>">
    <param name="allowFullscreen" value="true" />
    <param name="allowScriptAccess" value="always" />
    <param name="movie" value="/jaris/JarisFLVPlayer.swf" />
    <param name="bgcolor" value="#000000" />
    <param name="quality" value="high" />
    <param name="scale" value="noscale" />
    <param name="wmode" value="opaque" />
    <param name="flashvars" value="source=<%=Model.Video%>&amp;type=video&amp;duration=52&amp;streamtype=file&amp;autostart=false&amp;amp;hardwarescaling=false&amp;darkcolor=000000&amp;brightcolor=4c4c4c&amp;controlcolor=FFFFFF&amp;hovercolor=67A8C1&amp;controltype=1" />
    <param name="seamlesstabbing" value="false" />
    <embed type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"
        width="576" height="360" src="/jaris/JarisFLVPlayer.swf" allowfullscreen="true"
        allowscriptaccess="always" bgcolor="#000000" quality="high" scale="noscale" wmode="opaque"
        flashvars="source=<%=Model.Video%>&amp;type=video&amp;duration=52&amp;streamtype=file&amp;autostart=false&amp;hardwarescaling=false&amp;controltype=1"
        seamlesstabbing="false" />
    <noembed>
  </noembed>
</object>--%>
