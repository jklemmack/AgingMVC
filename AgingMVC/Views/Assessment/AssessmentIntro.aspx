<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Assessment.Master"
    Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Domain>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.DomainName%>
    Evaluation
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Introduction to the
            <%:Model.Name %>
            Evaluation
        </h1>
    </div>
    <iframe src="<%:ViewBag.VideoURL %>" width="950" height="600"></iframe>
    <div>
        <div>
            <a href="/" class="back">Return to Main Page</a></div>
        <div class="rightnav">
            <a href="/Assessment/<%: ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page + 1 %>"
                class="back">Next</a></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
