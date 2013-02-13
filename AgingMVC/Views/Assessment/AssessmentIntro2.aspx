<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Domain>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    AssessmentIntro
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
    <ul id="mycarousel" class="jcarousel-skin-name">
        <!-- Carousel of available videos-->
        <% foreach (var video in Model.Videos)
           { %>
        <li>
            <img src="<%: Url.Content(video.ThumbImageURL) %>" alt="<%: video.ShortText %>" width="367"
                height="109" />
            <%:video.ShortText %>
        </li>
        <%} %>
    </ul>
    <div>
        <div>
            <a href="/" class="back">Return to Main Page</a></div>
        <div class="rightnav">
            <a href="/Assessment/<%: ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page + 1 %>"
                class="back">Proceed to the Assessment</a></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <link href="<%: Url.Content("~/Content/jCarouselSkin.css") %>" rel="stylesheet" type="text/css" />
    <script src="<%: Url.Content("~/Scripts/jquery.jcarousel.min.js") %>" type="text/javascript"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery('#mycarousel').jcarousel({
                // Configuration goes here
            });
        });

        //jwplayer.key = "mp6SILGik5i77LMmvhRE9W+LQOAFMt0tPRJH3w==";

    </script>
    <script src="<%: Url.Content("~/jwplayer/jwplayer.js") %>" type="text/javascript"></script>
</asp:Content>
