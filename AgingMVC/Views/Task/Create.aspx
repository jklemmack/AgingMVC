<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Task>" %>

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
        <legend>Task</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.ObjectiveId, "Objective") %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownList("ObjectiveId", String.Empty) %>
            <%: Html.ValidationMessageFor(model => model.ObjectiveId) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.DomainId, "Domain") %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownList("DomainId", String.Empty) %>
            <%: Html.ValidationMessageFor(model => model.DomainId) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.TaskOrder) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.TaskOrder) %>
            <%: Html.ValidationMessageFor(model => model.TaskOrder) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.ShortText) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.ShortText) %>
            <%: Html.ValidationMessageFor(model => model.ShortText) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.PromptText) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.PromptText) %>
            <%: Html.ValidationMessageFor(model => model.PromptText) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.AssessmentText) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.AssessmentText) %>
            <%: Html.ValidationMessageFor(model => model.AssessmentText) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.PromptTextSelf) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.PromptTextSelf) %>
            <%: Html.ValidationMessageFor(model => model.PromptTextSelf) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.AssessmentTextSelf) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.AssessmentTextSelf) %>
            <%: Html.ValidationMessageFor(model => model.AssessmentTextSelf) %>
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
