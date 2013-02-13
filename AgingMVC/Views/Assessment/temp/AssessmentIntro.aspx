<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Domain>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    AssessmentIntro
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Assessment Intro :
            <%:Model.Name %></h1>
    </div>
   <%-- <p>
        <%=Model.SummaryText %></p>--%>

        <iframe src="<%:ViewBag.VideoURL %>" width="950" height="600"></iframe>

<%--        <div id='my-video'></div>
<script type='text/javascript'>
    jwplayer('my-video').setup({
        file: '/Content/Videos/MedicalDomain.flv',
        width: '480',
        height: '270'
    });
</script>
--%>    <div>
        <div>
            <a href="/" class="back">Return to Main Page</a></div>
        <div class="rightnav">
            <a href="/Assessment/<%: ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page + 1 %>"
                class="back">Proceed to Next Objective</a></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
<%--    <script src="/jwplayer/jwplayer.js"></script>
    <script>        jwplayer.key = "mp6SILGik5i77LMmvhRE9W+LQOAFMt0tPRJH3w=="</script>
--%></asp:Content>
