<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="height: 340px;">
        <div style="position: absolute;">
            <img src="/images/home_photo.jpg" style="margin: -30px 0px 0px -45px;">
        </div>
        <div class="login_box">
            <script src="/Scripts/jquery.validate.min.js" type="text/javascript"></script>
            <script src="/Scripts/jquery.validate.unobtrusive.min.js" type="text/javascript"></script>
            <form action="/Account/LogOn" method="post">
            <div class="login_form">
                <fieldset>
                    <h2>
                        Begin Assessment</h2>
                    <div class="editor-field">
                        <div class="editor-label">
                            <label for="UserName">
                                User name</label>
                        </div>
                        <input data-val="true" data-val-required="The User name field is required." id="UserName"
                            name="UserName" type="text" value="" />
                        <span class="field-validation-valid" data-valmsg-for="UserName" data-valmsg-replace="true">
                        </span>
                    </div>
                    <div class="editor-field">
                        <div class="editor-label">
                            <label for="Password">
                                Password</label>
                        </div>
                        <input data-val="true" data-val-required="The Password field is required." id="Password"
                            name="Password" type="password" />
                        <span class="field-validation-valid" data-valmsg-for="Password" data-valmsg-replace="true">
                        </span>
                    </div>
                    <div class="editor-label">
                        <input data-val="true" data-val-required="The Remember me? field is required." id="RememberMe"
                            name="RememberMe" type="checkbox" value="true" /><input name="RememberMe" type="hidden"
                                value="false" />
                        <label for="RememberMe" style="color: #fff;">
                            Remember me?</label>
                    </div>
                    <p>
                        <input type="submit" value="Log On" />
                    </p>
                    <p style="font-size: 12px; color: #fff;">
                        If you do not have an account, you can
                        <%: Html.ActionLink("Register", "Register", "Account") %>
                        if your institution is a participating member.</p>
                </fieldset>
            </div>
            </form>
        </div>
        <div style="clear: both;">
        </div>
    </div>
    <div class="home_content">
        <div class="home_left">
            <p>
                Are you ready to help your parents plan for the future? Do you know how to plan
                for your own future? This online tool will help you identify key tasks that you
                or your parents need to complete in the future, such as creating a living will,
                having a comprehensive care plan, and deciding when someone is no longer safe to
                drive. The assessment is broken down into four categories: medical, legal, emotional,
                and social. At the end of each category you will learn what your high priority tasks
                are and you will be given access to national and state-based resources that have
                been critically approved and reviewed in order to help you address elder care challenges
                you may face in the future for either yourself or your parents. The Parent Care
                Readiness Assessment will help you and your family be more prepared for the future!</p>
            <p>
                <img src="../../images/home_thumb_medical.jpg" width="116" height="130" />
                <img src="../../images/home_thumb_legal.jpg" width="116" height="130" />
           
                <img src="../../images/home_thumb_family.jpg" width="115" height="130" />
                <img src="../../images/home_thumb_emotional.jpg" width="115" height="130" /></p>
        </div>
        <div class="home_right">
            <img src="/images/video_filler.jpg" width="367" height="109" /><br />
            <br />
            <img src="/images/video_filler.jpg" width="367" height="109" /><br />
            <br />
            <p>
                Please
                <%: Html.ActionLink("Log On", "LogOn", "Account") %>
                to access the Parent Care Readiness Assessment. If you do not have an account, you
                can
                <%: Html.ActionLink("Register", "Register", "Account") %>
                if your institution is a participating member.
            </p>
        </div>
        <div style="clear: both;">
        </div>
    </div>
</asp:Content>
