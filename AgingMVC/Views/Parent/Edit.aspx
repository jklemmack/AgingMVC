<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Parent>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeaderContent" runat="server">
<style>
    .button{
        background: none repeat scroll 0 0 #A82300;
        border: 0 none;
        border-radius: 5px 5px 5px 5px;
        color: white;
        font-size: 1.2em;
        padding: 5px;
    }
</style></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

 <div class="heading"><h1>Edit</h1></div>

<script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>" type="text/javascript"></script>
<script src="<%: Url.Content("~/Scripts/jquery.validate.unobtrusive.min.js") %>" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

    $(document).ready(function () {

        $("#Delete").click(function () {
            if (!confirm('Are you sure you wish to remove this record?  You will not be able to undo this action.'))
                return;
            $("form").attr("action", "/Parent/Delete/<%:Model.FirstName %>");
            $("form").submit(); 
        });

    });


</script>


<% using (Html.BeginForm("Edit", "Parent")) { %>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        <legend>Parent</legend>

        <%: Html.HiddenFor(model => model.UserID) %>

        <%: Html.HiddenFor(model => model.ParentID) %>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.Relationship) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.Relationship) %>
            <%: Html.ValidationMessageFor(model => model.Relationship) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.FirstName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.FirstName) %>
            <%: Html.ValidationMessageFor(model => model.FirstName) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.Age) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.Age) %>
            <%: Html.ValidationMessageFor(model => model.Age) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.State, "State1") %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownList("State", String.Empty) %>
            <%: Html.ValidationMessageFor(model => model.State) %>
        </div>
        <p>
            <input type="submit" value="Save" />
            <%--<input type="submit" value="Delete" style="margin-left: 100px;" />--%>
            <button id="Delete" class="button">Delete</button>
        </p>
    </fieldset>
<% } %>


<div>
    <%: Html.ActionLink("Back to List", "Index", "Home") %>
</div>

</asp:Content>
