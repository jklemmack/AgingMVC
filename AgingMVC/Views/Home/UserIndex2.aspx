<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    AgeReady : Home
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeaderContent" runat="server">
    <style type="text/css">
        #topwrapper
        {
        }
        
        #carerecipientlist
        {
            float: left;
            width: 150px;
            height: 100%;
        }
        
        #overview
        {
            height: 100%;
            margin-bottom: 0;
            margin-left: 200px;
        }
        
        #domains
        {
            height: 150px;
            margin-bottom: 20px;
            margin-left: 190px;
            width: 700px;
        }
        
        div .domain
        {
            width: 140px;
            height: 200px;
            float: left;
            text-align: center;
            margin: 5px;
        }
        
        .carerecipientselected
        {
            background-color: #961200;
            border-radius: 5px 5px 5px 5px;
            color: White;
            margin: 10px 0;
            padding: 10px;
        }
        
        div .bardivs
        {
            position: relative;
            margin-bottom: 10px;
        }
        
        div .progresstext
        {
            width: 100%;
            position: absolute;
            top: 5px;
            text-align: center;
        }
    </style>
    <script language="javascript" type="text/javascript">
        
        var parentData = <%=ViewBag.ParentData %>
        var selectedParent = '';

        $(document).ready(function () {

            SetParentLinks($("#Parent").val());

            SetProgressBars();

            $("#Parent").change(function () {
                var parent = $("#Parent").val();
                SetParentLinks(parent);
            });
            
            <% if (ViewBag.FirstParent != null)
                 Response.Write(string.Format("NavigateToParent('{0}');", ViewBag.FirstParent));
            %>
        });

        function NavigateToParent(parent) {
            window.location.hash = parent;
            selectedParent = parent;
            SetParentLinks(parent);
            $('.carerecipientselected').each(function() { 
                $(this).removeClass('carerecipientselected'); 
                });
            $('#carerecipient[parent=' + parent + ']').addClass('carerecipientselected');


            var p = parentData[parent];
            $("#MedicalProgress").attr("progress", p.MedicalProgress);
            $("#LegalProgress").attr("progress", p.LegalProgress);
            $("#SocialProgress").attr("progress", p.SocialProgress);
            $("#EmotionalProgress").attr("progress", p.EmotionalProgress);

            SetProgressBars();
            SetProgressText();
        }

        function SetParentLinks(parent) {
            $("#Medical").attr("href", "/Assessment/Medical/" + parent);
            $("#Legal").attr("href", "/Assessment/Legal/" + parent);
            $("#Social").attr("href", "/Assessment/Social/" + parent);
            $("#Emotional").attr("href", "/Assessment/Emotional/" + parent);

            $("#MedicalResources").click(function() { window.location = "/Resources/" + selectedParent + "/Medical"; });
            $("#MedicalResources").css('cursor', 'pointer');

            $("#LegallResources").click(function() { window.location = "/Resources/" + selectedParent + "/Legal"; });
            $("#LegallResources").css('cursor', 'pointer');

            $("#SocialResources").click(function() { window.location = "/Resources/" + selectedParent + "/Social"; });
            $("#SociallResources").css('cursor', 'pointer');

            $("#EmotionalResources").click(function() { window.location = "/Resources/" + selectedParent + "/Emotional"; });
            $("#EmotionalResources").css('cursor', 'pointer');
        }

        function SetProgressBars() {
            $('.progressbar').each(function () {
                var value = parseInt($(this).attr('progress'));
                $(this).progressbar({ value: value });

            });
        }

        function SetProgressText(){
            $('.bardivs').each(function () {
                var value = parseInt($(this).find('.progressbar').attr('progress'));
                if (value == 100)
                {
                    //$(this).find('.progresstext').show();
                    $(this).find('.progresstext').html('View Resources');
                } else {
                    //$(this).find('.progresstext').hide();
                    $(this).find('.progresstext').html('Enter assessment');
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Overview</h1>
    </div>
    <div id="topwrapper">
        <div id="carerecipientlist">
            Step 1: Step 2: Step 3:
        </div>
        <div id="overview">
            <div style="margin-bottom: 5px;">
                I am the model of a modern major general.</div>
            <div id="carerecipient" class="display-field" style="cursor: pointer; dispaly: inline-block;
                float: left; margin: 0 15px 25px 0; width: 130px; height: 100px;">
                David
                <div style="position: relative;">
                    <div class="progressbar" progress="10">
                    </div>
                    <div style="width: 100%;">
                        <a href="/Parent/Edit/David" style="color: White; font-size: small; margin-top: 5px;
                            text-align: center;">Recipient details</a></div>
                    <div style="width: 100%;">
                    </div>
                </div>
            </div>
            <div id="carerecipient" class="display-field" style="cursor: pointer; dispaly: inline-block;
                float: left; margin: 0 15px 25px 0; width: 130px; height: 100px;">
                David
                <div style="position: relative;">
                    <div class="progressbar" progress="10">
                    </div>
                    <div style="width: 100%;">
                        <a href="/Parent/Edit/David" style="color: White; font-size: small; margin-top: 5px;
                            text-align: center;">Recipient details</a></div>
                    <div style="width: 100%;">
                    </div>
                </div>
            </div>
            <div id="Div1" class="display-field" style="cursor: pointer; dispaly: inline-block;
                float: left; margin: 0 15px 25px 0; width: 130px; height: 100px;">
                <div style="position: relative; vertical-align: middle; text-align: center;">
                    Create a new care recipient
                </div>
            </div>
        </div>
    </div>
    <div id="domains" style="clear: both;">
        <div style="background-color: #961200; border-radius: 5px 5px 5px 5px; min-height: 225px;">
            <div class="domain">
                <a name="Medical" id="Medical" href="/">
                    <img src="/images/home_thumb_medical.jpg" width="116" alt="Link to Medical Assessment" /><br />
                </a>
                <div>
                    8 of 17 tasks completed</div>
                <div>
                    <a href="#">View Important Medical Tasks and Resources</a></div>
            </div>
            <div class="domain">
                <a name="Legal" id="Legal" href="/">
                    <img src="/images/home_thumb_legal.jpg" width="116" /><br />
                </a>
                <div>
                    Assessment not completed
                </div>
                <div>
                    <a href="#">Continue Legal & Financial Evaluation</a></div>
            </div>
            <div class="domain" style="text-align: center;">
                <div class="bardivs">
                    <div class="progressbar" id="SocialProgress">
                    </div>
                    <div class="progresstext">
                        View Resources
                    </div>
                </div>
                <a name="Social" id="Social" href="/">
                    <img src="/images/home_thumb_family.jpg" width="115" /><br />
                    Enter Social Assessment</a></div>
            <div class="domain">
                <div class="bardivs">
                    <div class="progressbar" id="EmotionalProgress">
                    </div>
                    <div class="progresstext">
                        View Resources
                    </div>
                </div>
                <a name="Emotional" id="Emotional" href="/">
                    <img src="/images/home_thumb_emotional.jpg" width="115" /><br />
                    Enter Emotional Assessment</a></div>
        </div>
    </div>
</asp:Content>
