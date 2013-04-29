<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="Scripts/slides.min.jquery.js"></script>
    <script>
        $(function () {
            $("#slides").slides({
                fadeSpeed: 350,
                effect: 'fade',
                play: 5000,
                crossfade: true
            });
        });
    </script>
    <style>
        #slides
        {
            margin: -30px 0 0 -44px;
            position: absolute;
        }
        
        /*
	Slides container
	Important:
	Set the width of your slides container
	Set to display none, prevents content flash
*/
        
        .slides_container
        {
            width: 1022px;
            position: relative;
            display: none;
        }
        
        /*
	Each slide
	Important:
	Set the width of your slides
	If height not specified height will be set by the slide content
	Set to display block
*/
        
        .slides_container a
        {
            width: 1022px;
            height: 362px;
            display: block;
        }
        
        .slides_container a img
        {
            display: block;
        }
        
        /*
	Next/prev buttons
*/
        
        #slides .next, #slides .prev
        {
            position: absolute;
            top: 107px;
            left: -39px;
            width: 24px;
            height: 43px;
            display: block;
            z-index: 101;
        }
        
        #slides .next
        {
            left: 585px;
        }
        
        /*
	Pagination
*/
        
        .pagination
        {
            margin: 26px auto 0;
            width: 100px;
        }
        
        .pagination li
        {
            float: left;
            margin: 0 1px;
            list-style: none;
        }
        
        .pagination li a
        {
            display: block;
            width: 12px;
            height: 0;
            padding-top: 12px;
            background-image: url(../img/pagination.png);
            background-position: 0 0;
            float: left;
            overflow: hidden;
        }
        
        .pagination li.current a
        {
            background-position: 0 -12px;
        }
        
        /*
	Footer
*/
    </style>
    <div style="height: 340px;">
        <div id="slides">
            <div class="slides_container">
                <a href="">
                    <img src="/images/home_photo1.jpg"></a> <a href="">
                        <img src="/images/home_photo2.jpg"></a> <a href="">
                            <img src="/images/home_photo3.jpg"></a>
            </div>
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
            <div class="video_box">
                <img src="/images/video_thumb2.jpg" width="140" height="98" align="left" style="padding: 0px 10px 0px 0px;" />
                Most adult children assume care giving duties for a parent after a health event.
                In the movie "Dad", Jack Lemmon's wife, his primary care giver, suffers a heart
                attack and thrusts both of his adult children into caregiving duties - duties for
                which his son, played by Ted Danson, is totally unprepared. This video emphasizes
                the importance of being prepared for caring for an aging parent.<br />
                <br />
            </div>
            <div class="video_box" style="clear: both;">
                <img src="/images/video_thumb1.jpg" alt="" width="140" height="98" align="left" style="padding: 0px 10px 0px 0px;" />
                Dr. Michael Parker, selected by the Hartford Foundation and Gerontological Society
                of America as one of the top 10 geriatric scholars in the United States, explains
                the importance of completing the AgeReady Assessment.</div>
        </div>
        <div style="clear: both;">
        </div>
    </div>
</asp:Content>
