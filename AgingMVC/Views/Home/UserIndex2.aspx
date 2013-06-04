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
            width: 160px;
            height: 200px;
            float: left;
            text-align: center;
            margin: 5px;
            position: relative;
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
        
        div .assessmentlink
        {
            padding-top: 10px;
        }
    </style>
    <link href="/Content/jquery.loadmask.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        
        var parentData = <%=ViewBag.ParentData %>
        var selectedParent = null;
        jQuery.fn.visible = function() {
            return this.css('visibility', 'visible');
        }

        jQuery.fn.invisible = function() {
            return this.css('visibility', 'hidden');
        }

        jQuery.fn.visibilityToggle = function() {
            return this.css('visibility', function(i, visibility) {
                    return (visibility == 'visible') ? 'hidden' : 'visible';
                });
        }

        $(document).ready(function () {
            SetProgressBars();
            <% if (ViewBag.FirstParent != null) 
                 Response.Write(string.Format("NavigateToParent('{0}');", ViewBag.FirstParent));
               else
                 Response.Write("$('#domains').invisible();");
            %>
        });

        function NavigateToParent(parent, element) {
            window.location.hash = parent;
            selectedParent = parent;

            // Do loading delay:
            $("#domains").mask("Loading ...")
            window.setTimeout(function() {
                    SetParentLinks(parent)
                    $("#domains").unmask();
                    $('.carerecipientselected').each(function() { 
                        $(this).removeClass('carerecipientselected'); 
                        });
                    $('#carerecipient[parent=' + parent + ']').addClass('carerecipientselected');
                }, 1000);

            // Update the visible selected parent - removing the selection on any existing ones first
        }

        function SetParentLinks(parent) {
            var data = parentData[parent];


            /*** MEDICAL *********************************************************/
            $("#medicalImageLink").attr("href", "/Assessment/Medical/" + parent);
            $("#MedicalStatus").attr("href", "/Assessment/Medical/" + parent);
            if (data.MedicalAssessmentCompleted == data.MedicalTotal)
            {
                $("#MedicalStatus").text(data.MedicalTaskCompleted + " of " + data.MedicalTotal + " tasks completed");
                $("#MedicalLink").attr("href", "/Resources/" + selectedParent + "/Medical");
                $("#MedicalLink").text("View Important Medical Tasks and Resources");
            } else  {
                $("#MedicalStatus").text("Assessment not completed");
                if (data.MedicalAssessmentCompleted == 0)
                    $("#MedicalLink").text("Begin the Medical Assessment");
                else 
                    $("#MedicalLink").text("Continue the Medical Assessment");

                $("#MedicalLink").attr("href", "/Assessment/Medical/" + parent);
            }


            /*** LEGAL *********************************************************/
            $("#legalImageLink").attr("href", "/Assessment/Legal/" + parent);
            $("#LegalStatus").attr("href", "/Assessment/Legal/" + parent);
            if (data.LegalAssessmentCompleted == data.LegalTotal)
            {
                $("#LegalStatus").text(data.LegalTaskCompleted + " of " + data.LegalTotal + " tasks completed");
                $("#LegalLink").attr("href", "/Resources/" + selectedParent + "/Legal");
                $("#LegalLink").text("View Important Legal Tasks and Resources");
            } else  {
                $("#LegalStatus").text("Assessment not completed");
                if (data.LegalAssessmentCompleted == 0)
                    $("#LegalLink").text("Begin the Legal Assessment");
                else 
                    $("#LegalLink").text("Continue the Legal Assessment");

                $("#LegalLink").attr("href", "/Assessment/Legal/" + parent);
            }

            /*** SOCIAL *********************************************************/
            $("#socialImageLink").attr("href", "/Assessment/Social/" + parent);
            $("#SocialStatus").attr("href", "/Assessment/Social/" + parent);
            if (data.SocialAssessmentCompleted == data.SocialTotal)
            {
                $("#SocialStatus").text(data.SocialTaskCompleted + " of " + data.SocialTotal + " tasks completed");
                $("#SocialLink").attr("href", "/Resources/" + selectedParent + "/Social");
                $("#SocialLink").text("View Important Social Tasks and Resources");
            } else  {
                $("#SocialStatus").text("Assessment not completed");
                if (data.SocialAssessmentCompleted == 0)
                    $("#SocialLink").text("Begin the Social Assessment");
                else 
                    $("#SocialLink").text("Continue the Social Assessment");

                $("#SocialLink").attr("href", "/Assessment/Social/" + parent);
            }

            /*** EMOTIONAL *********************************************************/
            $("#emotionalImageLink").attr("href", "/Assessment/Emotional/" + parent);
            $("#EmotionalStatus").attr("href", "/Assessment/Emotional/" + parent);
            if (data.EmotionalAssessmentCompleted == data.EmotionalTotal)
            {
                $("#EmotionalStatus").text(data.EmotionalTaskCompleted + " of " + data.EmotionalTotal + " tasks completed");
                $("#EmotionalLink").attr("href", "/Resources/" + selectedParent + "/Emotional");
                $("#EmotionalLink").text("View Important Emotional Tasks and Resources");
            } else  {
                $("#EmotionalStatus").text("Assessment not completed");
                if (data.EmotionalAssessmentCompleted == 0)
                    $("#EmotionalLink").text("Begin the Emotional Assessment");
                else 
                    $("#EmotionalLink").text("Continue the Emotional Assessment");

                $("#EmotionalLink").attr("href", "/Assessment/Emotional/" + parent);
            }


        }

        function SetProgressBars() {
            $('.progressbar').each(function () {
                var value = parseInt($(this).attr('progress'));
                $(this).progressbar({ value: value });

            });
        }

        function CreateNewParent()
        {
            window.location = "/Parent/Create";
        }

    </script>
    <script src="/Scripts/jquery.loadmask.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Home</h1>
    </div>
    <div id="topwrapper">
        <fieldset id="carerecipientlist" style="min-height: 300px;">
            <p>
                <span style="font-weight: 700; font-size: 21px; color: #3C7491">Step 1: </span>
                <br />
                Select a care recipient, or create a new one.
            </p>
            <p>
                <span style="font-weight: 700; font-size: 21px; color: #3C7491">Step 2: </span>
                <br />
                Complete the evaluation for this person in each of the four categories.
            </p>
            <p>
                <span style="font-weight: 700; font-size: 21px; color: #3C7491">Step 3: </span>
                <br />
                Access resources to help you complete the most important tasks that were identified
                in each category.
            </p>
        </fieldset>
        <div style="width: 700px; margin-left: 190px; min-height: 50px;">
            <p style="font-size: 16px; line-height: 20px;">
                The AgeReady Program is designed using the transtheoretical model of change, a proven
                model that helps people become informed, formulate a strategy, and act on a new,
                better behavior.
            </p>
            <p>
                To begin, just follow the three steps you see on the left.</p>
        </div>
        <div style="width: 700px; margin-left: 190px; min-height: 150px;">
            <%foreach (AgingMVC.Models.vw_ParentSummary parent in Model.ParentSummaries)
              {%>
            <div id="carerecipient" class="display-field" style="cursor: pointer; display: inline-block;
                float: left; margin: 0 15px 25px 0; width: 130px; height: 100px;" parent="<%:parent.FirstName %>"
                onclick="NavigateToParent('<%:parent.FirstName %>', this)">
                <%:parent.FirstName %>
                <div style="position: relative;">
                    <div class="progressbar" progress="<%: Math.Round( 100.0 * parent.Completed / parent.Total ) %>">
                    </div>
                    <div class="under_progress">
                        Percentage of Tasks Completed</div>
                    <div style="width: 100%;">
                        <a href="/Parent/Edit/<%:parent.FirstName %>" style="background: none repeat scroll 0 0 #F5F5F5;
                            border-radius: 4px 4px 4px 4px; box-shadow: 1px 1px 1px #AAAAAA; color: #3C7491;
                            padding: 4px; font-size: small; margin-top: 15px; display: block; text-align: center;
                            text-decoration: none;">Recipient details</a></div>
                    <div style="width: 100%;">
                    </div>
                </div>
            </div>
            <%} %>
            <%if (ViewBag.CanAddParent)
              {%>
            <div id="Div1" class="display-field" style="cursor: pointer; display: inline-block;
                float: left; margin: 0 15px 25px 0; width: 130px; height: 100px;" onclick="CreateNewParent();">
                Add New Care Recipient
            </div>
            <%} %>
        </div>
    </div>
    <div id="domains" style="border-color: #edeae5; border-width: medium; border-style: solid;
        min-height: 250px;">
        <div class="domain">
            <a name="Medical" id="medicalImageLink" href="/">
                <img src="/images/home_thumb_medical.jpg" width="116" alt="Link to Medical Assessment" /><br />
            </a>
            <div>
                <a href="#" id="MedicalStatus">Assessment not completed</a>
            </div>
            <div class="assessmentlink">
                <a href="#" id="MedicalLink">Continue Medical Evaluation</a></div>
        </div>
        <div class="domain">
            <a name="Legal" id="legalImageLink" href="/">
                <img src="/images/home_thumb_legal.jpg" width="116" /><br />
            </a>
            <div>
                <a href="#" id="LegalStatus">Assessment not completed</a>
            </div>
            <div class="assessmentlink">
                <a href="#" id="LegalLink">Continue Legal & Financial Evaluation</a></div>
        </div>
        <div class="domain">
            <a name="Social" id="socialImageLink" href="/">
                <img src="/images/home_thumb_family.jpg" width="116" /><br />
            </a>
            <div>
                <a href="#" id="SocialStatus">Assessment not completed</a>
            </div>
            <div class="assessmentlink">
                <a href="#" id="SocialLink">Continue Family & Social Evaluation</a></div>
        </div>
        <div class="domain">
            <a name="Emotional" id="emotionalImageLink" href="/">
                <img src="/images/home_thumb_emotional.jpg" width="116" /><br />
            </a>
            <div>
                <a href="#" id="EmotionalStatus">Assessment not completed</a>
            </div>
            <div class="assessmentlink">
                <a href="#" id="EmotionalLink">Continue Spiritual & Emotional Evaluation</a></div>
        </div>
    </div>
</asp:Content>
