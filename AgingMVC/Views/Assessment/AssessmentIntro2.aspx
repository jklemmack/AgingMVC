<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Domain>" %>

<%@ Import Namespace="AgingMVC.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.DomainName%>
    Evaluation
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Begin
            <%:Model.ShortName %>
            Evaluation</h1>
    </div>
    <div>
        <%=Model.DescriptionText %>
        <p>
            <%=Model.ObjectivesText %></p>
    </div>
    <div>
        The following videos help to illustrate the importance of the
        <%:Model.ShortName %>
        tasks.</div>
    <ul id="mycarousel" class="jcarousel-skin-tango">
        <!-- Carousel of available videos-->
        <% foreach (var video in ViewBag.Videos)
           { %>
        <li class="carouselitem" videoindex="<%:video.Index%>" style="cursor: pointer;">
            <div align="center">
                <img src="<%: Url.Content(video.ThumbImageURL) %>" alt="<%: (string) video.ShortText %>" width="367"
                    height="109" /><br />
                <%:video.Description%></div>
        </li>
        <%} %>
    </ul>
    <div>
        <div style="float: left;">
            <a href="/" class="back">Return to Main Page</a></div>
        <div class="rightnav">
            <a href="/Assessment/<%: ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page + 1 %>"
                class="back">Proceed to the Assessment</a></div>
    </div>
    <div id="videoDialog" style="display: none;">
        <div id="videoContainer">
            Loading the player ...</div>
        <script type="text/javascript">
     
        </script>
        <div id="videodescription">
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <link href="<%: Url.Content("~/Content/jCarouselSkin.css") %>" rel="stylesheet" type="text/css" />
    <script src="<%: Url.Content("~/Scripts/jquery.jcarousel.min.js") %>" type="text/javascript"></script>
    <script src="/jwplayer/jwplayer.js" type="text/javascript"></script>
    <script type="text/javascript">
        var videos = <%=ViewBag.VideoDescriptions %>;

        $(function () {
            $(".carouselitem").click(function () {
                var videoindex = $(this).attr("videoindex");

                var item = [{
                        file: videos[videoindex].URL, 
                        image: videos[videoindex].ThumbImageURL,
                        title: videos[videoindex].ShortText 
                    }];

                jwplayer("videoContainer").load(item);

                $("#videodescription").html(videos[videoindex].Description);

                $("#videoDialog ").dialog({ modal: true,
                    title: videos[videoindex].ShortText,
                    resizable: false,
                    width: 520,
                    height: "auto",
                    buttons: { Ok: function () { $(this).dialog("close"); } }
                });

            });

            $("#videoDialog").on("dialogclose", function(event, ui) {
                jwplayer().stop();
            });

            $("#videoDialog").on("dialogopen", function(event, ui) {
                jwplayer().play();
            });

           jwplayer("videoContainer").setup({
                flashplayer: '/jwplayer/jwplayer.flash.swf',
                controlbar: 'bottom',
                height: 270,
                width: 480,
                file: '/Content/Videos/IntroParentCare.mp4' // Dummy placeholder video!
            });  
        });

        jQuery(document).ready(function () {
            jQuery('#mycarousel').jcarousel({
                // Configuration goes here
            });

            jwplayer().key = "mp6SILGik5i77LMmvhRE9W+LQOAFMt0tPRJH3w==";

        });

        
    </script>
</asp:Content>
