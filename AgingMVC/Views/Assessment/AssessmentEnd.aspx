<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    AssessmentEnd
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            <%:Model.ShortName %>
            Evaluation Completed</h1>
    </div>
    <div>
        <div>
            <a href="/Assessment/<%: ViewBag.Parent %>/<%: ViewBag.Page - 1 %>" class="back">Back</a></div>
        <div class="rightnav">
            <a href="/" class="back">Return to the Main Page</a></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
