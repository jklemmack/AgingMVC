<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Domain>" %>

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
        <p>
            This concludes the
            <%:Model.ShortName %>
            evaluation and we have determined the most important tasks for you to complete first.
            Use the link below to return to the main page, where you can now find links to national
            and state-specific resources that will help identify resource so you can complete
            these tasks.</p>
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
