<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Task>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Edit</h2>

<script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>" type="text/javascript"></script>
<script src="<%: Url.Content("~/Scripts/jquery.validate.unobtrusive.min.js") %>" type="text/javascript"></script>
<script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
<% using (Html.BeginForm()) { %>
    <%: Html.ValidationSummary(true) %>
    
        <%: Html.HiddenFor(model => model.TaskId) %>
        <%: Html.HiddenFor(model => model.ObjectiveId) %>

    <table>

    <tr>
    <td><%: Html.LabelFor(model => model.DomainId, "Domain") %></td>
    <td><%: Html.DropDownList("DomainId", String.Empty) %>
            <%: Html.ValidationMessageFor(model => model.DomainId) %></td>
    </tr>

    <tr>
    <td><%: Html.LabelFor(model=>model.TaskOrder) %></td>
    <td><%: Html.EditorFor(model => model.TaskOrder) %>
            <%: Html.ValidationMessageFor(model => model.TaskOrder) %></td>
    </tr>

    <tr>
    <td><%: Html.LabelFor(model=>model.ShortText) %></td>
    <td><%: Html.EditorFor(model => model.ShortText) %>
            <%: Html.ValidationMessageFor(model => model.ShortText) %></td>
    </tr>
            <tr>
    <td valign="top"><%: Html.LabelFor(model => model.PromptTextSelf)%></td>
    <td><%: Html.EditorFor(model => model.PromptTextSelf)%>
            <%: Html.ValidationMessageFor(model => model.PromptTextSelf)%></td>
    </tr>

    <tr>
    <td valign="top"><%: Html.LabelFor(model => model.PromptText) %></td>
    <td><%: Html.EditorFor(model => model.PromptText) %>
            <%: Html.ValidationMessageFor(model => model.PromptText) %></td>
    </tr>
    <tr>
    <td valign="top"><%: Html.LabelFor(model => model.AssessmentText)%></td>
    <td><%: Html.EditorFor(model => model.AssessmentText)%>
            <%: Html.ValidationMessageFor(model => model.AssessmentText)%></td>
    </tr>
        <tr>
    <td valign="top"><%: Html.LabelFor(model => model.AssessmentTextSelf)%></td>
    <td><%: Html.EditorFor(model => model.AssessmentTextSelf)%>
            <%: Html.ValidationMessageFor(model => model.AssessmentTextSelf)%></td>
    </tr>
    </table>

   
            <input type="submit" value="Save" />
   <% } %>

<div>
    <%: Html.ActionLink("Back to List", "Index") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
<script language="javascript" type="text/javascript">
    $(function () {
        CKEDITOR.replace('AssessmentText');
        CKEDITOR.replace('AssessmentTextSelf');
    });
</script>
<style type="text/css">
    input#ShortText { width: 95%; }
    input#PromptTextSelf { width: 95%; }
    input#PromptText { width: 95%; }
</style>
</asp:Content>
