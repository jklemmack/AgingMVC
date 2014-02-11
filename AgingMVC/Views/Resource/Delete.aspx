<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Resource>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Delete
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Delete</h2>

<h3>Are you sure you want to delete this?</h3>
<fieldset>
    <legend>Resource</legend>

    <div class="display-label">Active</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.Active) %>
    </div>

    <div class="display-label">Name</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.Name) %>
    </div>

    <div class="display-label">Description</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.Description) %>
    </div>

    <div class="display-label">State</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.State.StateName) %>
    </div>

    <div class="display-label">URL</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.URL) %>
    </div>
</fieldset>
<% using (Html.BeginForm()) { %>
    <p>
        <input type="submit" value="Delete" /> |
        <%: Html.ActionLink("Back to List", "Index") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
