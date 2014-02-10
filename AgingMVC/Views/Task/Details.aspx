<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Task>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Details</h2>

<fieldset>
    <legend>Task</legend>

    <div class="display-label">Objective</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.Objective.ObjectiveText) %>
    </div>

    <div class="display-label">Domain</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.Domain.Name) %>
    </div>

    <div class="display-label">TaskOrder</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.TaskOrder) %>
    </div>

    <div class="display-label">ShortText</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.ShortText) %>
    </div>

    <div class="display-label">PromptText</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.PromptText) %>
    </div>

    <div class="display-label">AssessmentText</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.AssessmentText) %>
    </div>

    <div class="display-label">PromptTextSelf</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.PromptTextSelf) %>
    </div>

    <div class="display-label">AssessmentTextSelf</div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.AssessmentTextSelf) %>
    </div>
</fieldset>
<p>

    <%: Html.ActionLink("Edit", "Edit", new { id=Model.TaskId }) %> |
    <%: Html.ActionLink("Back to List", "Index") %>
</p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">

</asp:Content>
