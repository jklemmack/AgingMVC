<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Objective>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.DomainName%>
    Objective
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading"><h1>
        <%:Model.Domain.Name %>
        Objective</h1></div>
    <%--<p>
        <%=Model.ObjectiveText %></p>--%>

    <iframe src="<%:ViewBag.VideoURL %>" width="950" height="600"></iframe>

    <div>
        <div>
            <a href="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page - 1 %>" class="back">Back</a></div>
        <div class="rightnav">
            <a href="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page + 1 %>" class="back">Proceed to Next Objective</a></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
