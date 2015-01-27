<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.ForgotPasswordModel>" %>

<asp:Content ID="fogotPasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Forgot Password
</asp:Content>

<asp:Content ID="forgotPasswordHeader" ContentPlaceHolderID="HeaderContent" runat="server">
    <style>
        .validation-summary-errors {
            display: none;
        }

        .validation-summary-valid {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="forgotPasswordContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h1>forogot Password</h1>
    </div>
    <p>
        Please enter your user name. <%: Html.ActionLink("Register", "Register") %> if you don't have an account.
    </p>

    <script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/jquery.validate.unobtrusive.min.js") %>" type="text/javascript"></script>

    <% using (Html.BeginForm())
       {
           
    %>

    <%if (!ViewData.ModelState.IsValid)
      {
          Html.ValidationSummary(true, "Action was unsuccessful. Please correct the errors and try again.");
      }%>
    <div>
        <fieldset>
            <legend>Account Information</legend>
            <input type="hidden" name="State" value="<%: Model.State.ToString() %>" />
            <%if (Model.State == AgingMVC.Models.ForgotPasswordStates.EnterUserName.ToString())
              { %>

            <div class="editor-label">
                <%: Html.LabelFor(m => m.UserName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(m => m.UserName) %>
                <%: Html.ValidationMessageFor(m => m.UserName) %>
            </div>
            <p>
                <input type="submit" value="Continue" />
            </p>

            <% }
              else if (Model.State == AgingMVC.Models.ForgotPasswordStates.EnterSecretAnswer.ToString())
              { %>

            <%: Html.HiddenFor(m=>m.UserName) %>
            <div class="editor-label">
                <%: Html.LabelFor(m => m.SecurityQuestion) %>
            </div>
            <div class="editor-field">
                <%: Model.SecurityQuestion %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(m => m.SecurityAnswer) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(m => m.SecurityAnswer) %>
            </div>
            <p>
                <input type="submit" value="Send My Password" />
            </p>
            <% }
              else if (Model.State == AgingMVC.Models.ForgotPasswordStates.Finalize.ToString())
              { %>
            A new password has been generated and has been emailed to your registered email address.
            <% } %>
        </fieldset>
    </div>
    <% } %>
</asp:Content>
