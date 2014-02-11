<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Resource>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Create
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Create</h2>

<script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>" type="text/javascript"></script>
<script src="<%: Url.Content("~/Scripts/jquery.validate.unobtrusive.min.js") %>" type="text/javascript"></script>

<% using (Html.BeginForm()) { %>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        <legend>Resource</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.Active) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.Active) %>
            <%: Html.ValidationMessageFor(model => model.Active) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.Name) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.Name) %>
            <%: Html.ValidationMessageFor(model => model.Name) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.Description) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.Description) %>
            <%: Html.ValidationMessageFor(model => model.Description) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.ResourceState, "State") %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownList("ResourceState", String.Empty) %>
            <%: Html.ValidationMessageFor(model => model.ResourceState) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.URL) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.URL) %>
            <%: Html.ValidationMessageFor(model => model.URL) %>
        </div>

        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "Index") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
