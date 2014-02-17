<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Domain>" %>

<%@ Import Namespace="AgingMVC.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.DomainName%>
    Evaluation
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="<%:ViewBag.ShortName %>heading">
        <h1>Begin Evaluation :
            <%:Model.Name %>
        </h1>
    </div>
    <div>
        <%=Model.DescriptionText %>
        <p>
            <%=Model.ObjectivesText %>
        </p>
    </div>
    <div>
        The following videos help to illustrate the importance of the
        <%:Model.ShortName %>
        tasks.
    </div>
    <ul id="mycarousel" class="jcarousel-skin-tango">
        <!-- Carousel of available videos-->
        <% foreach (var video in ViewBag.Videos)
           { %>
        <li class="carouselitem" videoindex="<%:video.Index%>" style="cursor: pointer;">
            <div align="center">
                <img src="<%: Url.Content(video.ThumbImageURL) %>" alt="<%: (string) video.ShortText %>"
                    width="367" height="109" /><br />
                <%: (string) video.ShortText %>
            </div>
        </li>
        <%} %>
    </ul>
    <div>
        <div style="float: left;">
            <a href="/" class="back">Return to Main Page</a>
        </div>
        <div class="rightnav">
            <a href="/Assessment/<%: ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page + 1 %>"
                class="back">Proceed to the Assessment</a>
        </div>
    </div>
    <div id="videoDialog" style="display: none;">
        <%--<video id="videoContainer" class="video-js vjs-default-skin" controls preload="none" width="576" height="360" data-setup="{}">
        </video>
        --%>
        <div id="videodescription">
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <link href="<%: Url.Content("~/Content/jCarouselSkin.css") %>" rel="stylesheet" type="text/css" />
    <script src="<%: Url.Content("~/Scripts/jquery.jcarousel.min.js") %>" type="text/javascript"></script>

    <link href="/videojs/video-js.css" rel="stylesheet" type="text/css">
    <script src="/videojs/video.dev.js"></script>

    <script type="text/javascript">
        var videos = <%=ViewBag.VideoDescriptions %>;
        var player = null;
        $(function () {
            videojs.options.flash.swf = "/videojs/video-js.swf";

            $(".carouselitem").click(function () {
                $("#videoDialog").prepend('<video id="videoContainer" class="video-js vjs-default-skin" controls preload="none" width="576" height="360" data-setup="{}"></video>');

                player = videojs('videoContainer');

                var videoindex = $(this).attr("videoindex");
                player.src([
                    {type: "video/m4v", src: videos[videoindex].URL}
                ]);

                $("#videodescription").html(videos[videoindex].Description);
                $("#videoDialog ").dialog({ modal: true,
                    resizable: false,
                    width: 590,
                    //title: videos[videoindex].Title,
                    height: "auto",
                    buttons: { Ok: function () { $(this).dialog("close"); } }
                });

            });

            $("#videoDialog").on("dialogclose", function(event, ui) {
                player.dispose();
            });

            $("#videoDialog").on("dialogopen", function(event, ui) {
                player.play();
            });

        });

        jQuery(document).ready(function () {
            jQuery('#mycarousel').jcarousel({
                // Configuration goes here
                buttonNextHTML: null,
                buttonPrevHTML: null
            });

        });
        
    </script>
</asp:Content>
