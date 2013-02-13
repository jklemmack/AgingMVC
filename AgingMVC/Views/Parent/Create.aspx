<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Parent>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Create
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

 <div class="heading"><h1>Create</h1></div>

<script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>" type="text/javascript"></script>
<script src="<%: Url.Content("~/Scripts/jquery.validate.unobtrusive.min.js") %>" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

    $(function () {
        $("input:radio[name='recipient']").change(function () {

            if ($("input:radio[name='recipient']:checked").val() == "self") {

                $("#Relationship").parent().hide();
                $("#Relationship").attr('originalValue', $("#Relationship").val());
                $("#Relationship").val('Myself');

                $("[for=Relationship]").parent().hide();

                $("#FirstName").parent().hide();
                $("#FirstName").attr('originalValue', $("#FirstName").val());
                $("#FirstName").val('Myself');

                $("[for=FirstName]").parent().hide();

            } else {
                $("#Relationship").parent().show();
                $("[for=Relationship]").parent().show();

                $("#Relationship").val($("#Relationship").attr('originalValue'));

                $("#FirstName").parent().show();
                $("[for=FirstName]").parent().show();
                $("#FirstName").val($("#FirstName").attr('originalValue'));

            }
        });
    });

</script>

<% using (Html.BeginForm()) { %>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        <div class="editor-label">
        Care Recipient
        </div>
        <div class="editor-field">
            <input type="radio" name="recipient" value="self" >Yourself</input>
            <input type="radio" name="recipient" value="other" checked="checked" >Someone else</input>
        </div>
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
            <%: Html.LabelFor(model => model.State, "State") %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownList("State", String.Empty) %>
            <%: Html.ValidationMessageFor(model => model.State) %>
        </div>

        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "Index", "Home") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
